#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./ip_environment"

    # Create the base directory
    mkdir -p "$base_dir"

    # Define IP addresses
    local ip_addresses=(
        "192.168.0.114"
        "192.168.0.135"
        "192.168.0.160"
        "192.168.0.164"
    )

    # Create a text file with IP addresses
    local ip_file="$base_dir/hosts-server.txt"
    for ip in "${ip_addresses[@]}"; do
        echo "$ip" >> "$ip_file"
    done

    printf "Environment setup complete. IP addresses file created in %s\n" "$ip_file"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./ip_environment"

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

