#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir1="./env1"
    local base_dir2="./env2"

    # Create the base directories
    mkdir -p "$base_dir1"
    mkdir -p "$base_dir2"

    # Define directories for both environments
    declare -A dirs=(
        ["$base_dir1/dir1"]=""
        ["$base_dir1/dir2"]=""
        ["$base_dir1/dir1/subdir1"]=""
        ["$base_dir1/dir2/subdir2"]=""
        ["$base_dir2/dir1"]=""
        ["$base_dir2/dir2"]=""
        ["$base_dir2/dir1/subdir1"]=""
        ["$base_dir2/dir2/subdir2"]=""
    )

    # Define files with specific content for both environments
    declare -A files=(
        ["$base_dir1/dir1/file1.txt"]="Line 1\nLine 2"
        ["$base_dir1/dir2/file2.txt"]="Line A\nLine B\nLine C"
        ["$base_dir1/dir1/subdir1/file3.txt"]="Alpha\nBeta\nGamma\nDelta"
        ["$base_dir1/dir2/subdir2/file4.txt"]="One\nTwo\nThree\nFour\nFive"
        ["$base_dir2/dir1/file1.txt"]="Line 1\nLine 2\nDifferent Line"
        ["$base_dir2/dir2/file2.txt"]="Line A\nLine B\nLine C\nDifferent Line"
        ["$base_dir2/dir1/subdir1/file3.txt"]="Alpha\nBeta\nGamma\nDelta\nDifferent Line"
        ["$base_dir2/dir2/subdir2/file4.txt"]="One\nTwo\nThree\nFour\nFive\nDifferent Line"
    )

    # Define identical files with the same content
    identical_content="Line 1\nLine 2\nLine 3\nLine 4\nLine 5"
    identical_files=(
        "$base_dir1/dir1/identical_file.txt"
        "$base_dir1/dir2/subdir2/identical_file.txt"
        "$base_dir2/dir1/identical_file.txt"
        "$base_dir2/dir2/subdir2/identical_file.txt"
    )

    # Create directories
    for dir in "${!dirs[@]}"; do
        mkdir -p "$dir"
    done

    # Create unique files with specified content
    for file in "${!files[@]}"; do
        printf "%s\n" "${files[$file]}" > "$file"
    done

    # Create identical files with the same content
    for file in "${identical_files[@]}"; do
        printf "%s\n" "$identical_content" > "$file"
    done

    printf "Environment setup complete. Directory structures with files created.\n"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir1="./env1"
    local base_dir2="./env2"

    if [[ -d "$base_dir1" ]]; then
        rm -rf "$base_dir1"
        printf "Environment 1 cleaned up. Directory structure removed.\n"
    else
        printf "Environment 1 directory does not exist. Nothing to clean up.\n"
    fi

    if [[ -d "$base_dir2" ]]; then
        rm -rf "$base_dir2"
        printf "Environment 2 cleaned up. Directory structure removed.\n"
    else
        printf "Environment 2 directory does not exist. Nothing to clean up.\n"
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

