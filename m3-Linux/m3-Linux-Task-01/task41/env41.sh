#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./config_environment"

    # Create the base directory
    mkdir -p "$base_dir"

    # Define the output .cfg file
    local cfg_file="$base_dir/config.cfg"

    # Create the .cfg file with some content
    echo "[Settings]" > "$cfg_file"
    echo "setting1=value1" >> "$cfg_file"
    echo "setting2=value2" >> "$cfg_file"
    echo "setting3=value3" >> "$cfg_file"

    printf "Environment setup complete. Configuration file created at %s\n" "$cfg_file"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./config_environment"

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

