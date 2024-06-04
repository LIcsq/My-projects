#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="/bash-task/task23/env_with_symlinks"

    # Create the base directory
    mkdir -p "$base_dir"

    # Define directories
    declare -A dirs=(
        ["$base_dir/dir1"]=""
        ["$base_dir/dir2"]=""
        ["$base_dir/dir1/subdir1"]=""
        ["$base_dir/dir1/subdir2"]=""
    )

    # Define files and their initial content
    declare -A files=(
        ["$base_dir/dir1/file1.txt"]="This is file1 in dir1."
        ["$base_dir/dir1/subdir1/file2.txt"]="This is file2 in subdir1."
        ["$base_dir/dir2/file3.txt"]="This is file3 in dir2."
    )

    # Create directories
    for dir in "${!dirs[@]}"; do
        mkdir -p "$dir"
    done

    # Create files with specified content
    for file in "${!files[@]}"; do
        printf "%s\n" "${files[$file]}" > "$file"
    done

    # Create symbolic links (absolute and relative)
    ln -s "$base_dir/dir1/file1.txt" "$base_dir/dir1/symlink_to_file1_absolute.txt"
    ln -s "../dir1/file1.txt" "$base_dir/dir2/symlink_to_file1_relative.txt"
    ln -s "$base_dir/dir1/subdir1" "$base_dir/dir1/symlink_to_subdir1_absolute"
    ln -s "../subdir1" "$base_dir/dir1/subdir2/symlink_to_subdir1_relative"

    printf "Environment setup complete. Directory structure with files and symbolic links created.\n"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./env_with_symlinks"

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

