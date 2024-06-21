#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./test_environment"
    local user="testuser"
    local group="testgroup"

    # Create the base directory
    mkdir -p "$base_dir"

    # Ensure the user and group exist
    if ! id -u "$user" &>/dev/null; then
        sudo useradd "$user"
    fi

    if ! getent group "$group" &>/dev/null; then
        sudo groupadd "$group"
    fi

    # Define directories and files with specific permissions
    declare -A dirs=(
        ["$base_dir/dir1"]="755"
        ["$base_dir/dir2"]="750"
    )

    declare -A files=(
        ["$base_dir/dir1/file1.txt"]="644:$user:$group"
        ["$base_dir/dir1/file2.txt"]="640:root:root"
        ["$base_dir/dir2/file3.txt"]="600:$user:$group"
        ["$base_dir/dir2/file4.txt"]="660:root:root"
    )

    # Create directories with specified permissions
    for dir in "${!dirs[@]}"; do
        mkdir -p "$dir"
        chmod "${dirs[$dir]}" "$dir"
        chown "$user:$group" "$dir"
    done

    # Create files with specified permissions
    for file in "${!files[@]}"; do
        local perm="${files[$file]%%:*}"
        local owner="${files[$file]#*:}"
        touch "$file"
        chmod "$perm" "$file"
        chown "$owner" "$file"
    done

    printf "Environment setup complete. Directory structure created with specified permissions.\n"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./test_environment"

    if [[ -d "$base_dir" ]]; then
        rm -rf "$base_dir"
        printf "Environment cleaned up. Directory structure removed.\n"
    else
        printf "Environment directory does not exist. Nothing to clean up.\n"
    fi
}

# Main function to orchestrate the script flow
main() {
    if [[ "$1" == "setup" ]]; then
        setup_environment
    elif [[ "$1" == "cleanup" ]]; then
        cleanup_environment
    else
        printf "Usage: $0 {setup|cleanup}\n"
        return 1
    fi
}

main "$@"

