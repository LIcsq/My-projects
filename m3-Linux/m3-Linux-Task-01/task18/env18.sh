#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./symlink_environment"
    local link_dir="$base_dir/links"
    local list_file="$base_dir/file_list.txt"

    # Create the base directory and links directory
    mkdir -p "$link_dir"

    # Define the list of files with relative paths and link directory paths
    declare -A files=(
        ["$base_dir/dir1/file1.txt"]="$link_dir/link_to_file1.txt"
        ["$base_dir/dir2/file2.txt"]="$link_dir/link_to_file2.txt"
        ["$base_dir/dir3/file3.txt"]="$link_dir/link_to_file3.txt"
        ["$base_dir/dir4/file4.txt"]="$link_dir/link_to_file4.txt"
        ["$base_dir/dir5/file5.txt"]="$link_dir/link_to_file5.txt"
    )

    # Create the files and the symlinks, and populate the list file
    for file in "${!files[@]}"; do
        local target_dir
        target_dir=$(dirname "$file")
        mkdir -p "$target_dir"
        echo "This is a test file: $file" > "$file"
        ln -s "$(realpath --relative-to="$link_dir" "$file")" "${files[$file]}"
        echo "$file ${files[$file]}" >> "$list_file"
    done

    printf "Environment setup complete. Files and symlinks created. List file is at %s\n" "$list_file"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./symlink_environment"

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
        printf "Usage: %s {setup|cleanup}\n" "$0"
        return 1
    fi
}

main "$@"

