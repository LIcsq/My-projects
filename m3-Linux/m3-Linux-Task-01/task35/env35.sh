#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./example_environment"

    # Create the base directory
    mkdir -p "$base_dir"

    # Define directories
    declare -A dirs=(
        ["$base_dir/dir1"]=""
        ["$base_dir/dir2"]=""
        ["$base_dir/dir3"]=""
    )

    # Create directories
    for dir in "${!dirs[@]}"; do
        mkdir -p "$dir"
    done

    # Create related .txt and .jpeg files in different subdirectories
    declare -A files=(
        ["$base_dir/dir1/file1.txt"]="This is the content of file1.txt"
        ["$base_dir/dir3/file8.txt"]="This is the content of file3.txt"
        ["$base_dir/dir1/file9.txt"]="This is the content of file1.txt"
	["$base_dir/dir2/file7.jpeg"]="This is the content of file1.jpeg"
	["$base_dir/dir2/file1.jpeg"]="This is the content of file1.jpeg"
        ["$base_dir/dir2/file2.txt"]="This is the content of file2.txt"
        ["$base_dir/dir1/file2.jpeg"]="This is the content of file2.jpeg"
        ["$base_dir/dir3/file3.txt"]="This is the content of file3.txt"
        ["$base_dir/dir1/file3.jpeg"]="This is the content of file3.jpeg"
    )

    # Create files with specified content
    for file in "${!files[@]}"; do
        printf "%s\n" "${files[$file]}" > "$file"
    done

    printf "Environment setup complete. Directory structure with files created.\n"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./example_environment"

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

