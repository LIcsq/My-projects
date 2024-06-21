#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./duplicate_env"

    # Create the base directory
    mkdir -p "$base_dir"

    # Define directories
    declare -A dirs=(
        ["$base_dir/dir1"]=""
        ["$base_dir/dir2"]=""
        ["$base_dir/dir1/subdir1"]=""
        ["$base_dir/dir2/subdir2"]=""
    )

    # Define files and their content
    declare -A files=(
        ["$base_dir/dir1/file1.txt"]="This is a text file in dir1."
        ["$base_dir/dir1/subdir1/file2.txt"]="This is a text file in subdir1."
        ["$base_dir/dir2/file3.txt"]="This is a text file in dir2."
        ["$base_dir/dir2/subdir2/file4.txt"]="This is a text file in subdir2."
        ["$base_dir/dir2/subdir2/file5.txt"]="This is a text file in subdir2."  # Duplicate of file4.txt
        ["$base_dir/dir1/duplicate1.txt"]="This is a duplicate file."
        ["$base_dir/dir2/duplicate2.txt"]="This is a duplicate file."  # Duplicate of duplicate1.txt
    )

    # Create directories
    for dir in "${!dirs[@]}"; do
        mkdir -p "$dir"
    done

    # Create files with specified content
    for file in "${!files[@]}"; do
        printf "%s\n" "${files[$file]}" > "$file"
    done

    printf "Environment setup complete. Directory structure with files created.\n"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./duplicate_env"

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

