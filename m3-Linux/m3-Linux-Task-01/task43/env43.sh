#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./hash_environment"
    local file_name="file_hashes.txt"

    # Create the base directory
    mkdir -p "$base_dir"

    # Define the output file with file names and hash values
    local output_file="$base_dir/$file_name"

    # Create the output file with some example content
    echo "file1.txt $(head -c 4 /dev/urandom | od -A n -t x1 | tr -d ' ')" > "$output_file"
    echo "file2.txt $(head -c 4 /dev/urandom | od -A n -t x1 | tr -d ' ')" >> "$output_file"
    echo "file3.txt $(head -c 4 /dev/urandom | od -A n -t x1 | tr -d ' ')" >> "$output_file"
    echo "file4.txt $(head -c 4 /dev/urandom | od -A n -t x1 | tr -d ' ')" >> "$output_file"
    echo "file5.txt $(head -c 4 /dev/urandom | od -A n -t x1 | tr -d ' ')" >> "$output_file"

    printf "Environment setup complete. File with hashes created at %s\n" "$output_file"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./hash_environment"

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

