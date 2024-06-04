#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./script_environment"

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
        ["$base_dir/dir3"]="root"
        ["$base_dir/dir3/subdir5"]="root"
    )

    # Define files and their content
    declare -A files=(
        ["$base_dir/dir1/file1.txt"]="This is a text file in dir1."
        ["$base_dir/dir1/subdir1/file2.sh"]="#!/bin/bash\necho 'This is a script file in subdir1.'"
        ["$base_dir/dir2/file3.conf"]="# Configuration file\nsetting=value"
        ["$base_dir/dir2/subdir3/file4.log"]="This is a log file in subdir3."
        ["$base_dir/dir3/file5.md"]="# Markdown file\n## This is a markdown file in dir3."
        ["$base_dir/dir3/subdir5/file6.sh"]="#!/bin/bash\necho 'This is a script file in subdir5.'"
    )

    # Create directories
    for dir in "${!dirs[@]}"; do
        if [[ "${dirs[$dir]}" == "root" ]]; then
            sudo mkdir -p "$dir"
            sudo chown root:root "$dir"
        else
            mkdir -p "$dir"
        fi
    done

    # Create files with specified content
    for file in "${!files[@]}"; do
        printf "%s\n" "${files[$file]}" > "$file"
        chmod +x "$file"
    done

    printf "Environment setup complete. Directory structure with various files created.\n"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./script_environment"

    if [[ -d "$base_dir" ]]; then
        sudo rm -rf "$base_dir"
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

