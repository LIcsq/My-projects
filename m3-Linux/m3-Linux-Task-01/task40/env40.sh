#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./ssl_environment"
    local domain="example.com"  # Replace with your target domain

    # Create the base directory
    mkdir -p "$base_dir"

    # Define the output file for the SSL certificate
    local cert_file="$base_dir/$domain.pem"

    # Fetch the SSL certificate
    echo | openssl s_client -connect "$domain:443" -servername "$domain" 2>/dev/null | openssl x509 > "$cert_file"

    printf "Environment setup complete. SSL certificate downloaded to %s\n" "$cert_file"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./ssl_environment"

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

