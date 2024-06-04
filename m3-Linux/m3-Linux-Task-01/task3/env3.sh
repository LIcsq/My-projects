#!/bin/bash

# Define the environment setup function
setup_environment() {
    local base_dir="./script_environment"

    # Create the base directory
    mkdir -p "$base_dir"

    # Define directories and files with specific permissions
    declare -A dirs=(
        ["$base_dir/dir1"]=""
        ["$base_dir/dir2"]=""
        ["$base_dir/dir1/subdir1"]=""
        ["$base_dir/dir1/subdir2"]=""
        ["$base_dir/dir2/subdir3"]=""
        ["$base_dir/dir2/subdir4"]=""
    )

    declare -A scripts=(
        ["$base_dir/dir1/script1.sh"]="#!/bin/bash\necho 'This is script1'"
        ["$base_dir/dir1/subdir1/script2.sh"]="#!/bin/bash\necho 'This is script2'"
        ["$base_dir/dir2/script3.sh"]="#!/bin/bash\necho 'This is script3'"
        ["$base_dir/dir2/subdir3/script4.sh"]="#!/bin/bash\necho 'This is script4'"
    )

    # Create directories
    for dir in "${!dirs[@]}"; do
        mkdir -p "$dir"
    done

    # Create script files with specified content
    for script in "${!scripts[@]}"; do
        printf "%s\n" "${scripts[$script]}" > "$script"
        chmod +x "$script"
    done

    printf "Environment setup complete. Directory structure with scripts created.\n"
}

# Define the environment cleanup function
cleanup_environment() {
    local base_dir="./script_environment"

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

