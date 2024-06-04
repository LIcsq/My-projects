#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./permissions_env"

    # Create the base directory
    mkdir -p "$base_dir"

    # Define directories
    declare -A dirs=(
        ["$base_dir/dir1"]=""
        ["$base_dir/dir2"]=""
        ["$base_dir/dir1/subdir1"]=""
        ["$base_dir/dir1/subdir2"]=""
        ["$base_dir/dir2/subdir3"]=""
        ["$base_dir/dir2/subdir4"]=""
    )

    # Define files, their content, and permissions
    declare -A files=(
        ["$base_dir/dir1/file1.txt"]="This is file1 in dir1.:644"
        ["$base_dir/dir1/subdir1/file2.txt"]="This is file2 in subdir1.:440"
        ["$base_dir/dir2/file3.txt"]="This is file3 in dir2.:644"
        ["$base_dir/dir2/subdir3/file4.log"]="This is file4 in subdir3.:644"
        ["$base_dir/dir2/subdir4/file5.conf"]="This is file5 in subdir4.:440"
    )

    # Create directories
    for dir in "${!dirs[@]}"; do
        mkdir -p "$dir"
    done

    # Create files with specified content and permissions
    for file in "${!files[@]}"; do
        local content="${files[$file]%%:*}"
        local perm="${files[$file]##*:}"
        printf "%s\n" "$content" > "$file"
        chmod "$perm" "$file"
    done

    printf "Environment setup complete. Directory structure with files created with specific permissions.\n"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./permissions_env"

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

