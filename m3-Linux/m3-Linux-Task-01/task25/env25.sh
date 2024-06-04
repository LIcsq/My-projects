
#!/bin/bash

# Function to create archives
setup_env() {
    # Create directory for archives
    mkdir -p archive_env
    cd archive_env || { echo "Failed to change directory to archive_env"; exit 1; }

    # Create a single test file
    echo "This is a test file for archiving" > testfile.txt

    # Create different archives

    # tar
    tar -cf archive.tar testfile.txt

    # gz
    tar -czf archive.tar.gz testfile.txt

    # bz2
    tar -cjf archive.tar.bz2 testfile.txt

    # Check if lzip is installed and create .lz archive
    if command -v lzip &> /dev/null; then
        tar --lzip -cf archive.tar.lz testfile.txt
    fi

    # lzma
    tar --lzma -cf archive.tar.lzma testfile.txt

    # xz
    tar -cJf archive.tar.xz testfile.txt

    # Check if compress is installed and create .Z archive
    if command -v compress &> /dev/null; then
        tar -cf - testfile.txt | compress -c > archive.tar.Z
    fi

    # Return to the original directory
    cd ..

    echo "Archives created in archive_env directory:"
}

# Function to clean up archives
cleanup_env() {
    # Remove the directory with archives
    rm -rf archive_env
}

# Main function
main() {
    if [ "$1" == "setup" ]; then
        setup_env
    elif [ "$1" == "cleanup" ]; then
        cleanup_env
    else
        echo "Unknown parameter. Use 'setup' to create archives or 'cleanup' to remove them."
        exit 1
    fi
}

# Call main function with the passed parameter
main "$1"

