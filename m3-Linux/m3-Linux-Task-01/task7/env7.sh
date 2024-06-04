#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="/bash-task/task7/symlink_env"

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

    # Define files and their content
    declare -A files=(
        ["$base_dir/dir1/file1.txt"]="This is file1 in dir1."
        ["$base_dir/dir1/subdir1/file2.txt"]="This is file2 in subdir1."
        ["$base_dir/dir2/file3.txt"]="This is file3 in dir2."
    )

    # Define symbolic links
    declare -A symlinks=(
        ["$base_dir/dir1/link_to_file1.txt"]="$base_dir/dir1/file1.txt"
        ["$base_dir/dir1/subdir2/link_to_file2.txt"]="$base_dir/dir1/subdir1/file2.txt"
        ["$base_dir/dir2/link_to_file3.txt"]="$base_dir/dir2/file3.txt"
        ["$base_dir/dir2/subdir4/link_to_file1.txt"]="$base_dir/dir1/file1.txt"
        ["$base_dir/dir2/subdir3/link_to_file2.txt"]="$base_dir/dir1/subdir1/file2.txt"
    )

    # Create directories
    for dir in "${!dirs[@]}"; do
        mkdir -p "$dir"
    done

    # Create files with specified content
    for file in "${!files[@]}"; do
        printf "%s\n" "${files[$file]}" > "$file"
    done

    # Create symbolic links
    for symlink in "${!symlinks[@]}"; do
        ln -s "${symlinks[$symlink]}" "$symlink"
    done

    printf "Environment setup complete. Directory structure with files and symbolic links created.\n"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./symlink_env"

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

