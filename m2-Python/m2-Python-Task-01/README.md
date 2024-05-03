### Password Generator
Description

This is a command-line password generator written in Python. It allows users to generate passwords based on various criteria such as length, template, character set, and count. The program also supports verbose logging and reading templates from a file.
Features

    Generate passwords of a specified length.

    Generate passwords based on a template.

    Generate passwords using a custom character set.

    Generate multiple passwords at once.

    Verbose logging for debugging and informational purposes.

    Read templates from a file to generate passwords.

Usage

The program can be run from the command line with various options to control the password generation process.

python password_generator.py [-h] [-n LENGTH] [-f FILE] [-t TEMPLATE] [-S SET] [-c COUNT] [-v]

## Options

    -n LENGTH, --length LENGTH: Set the length of the password to be generated.

    -f FILE, --file FILE: Read a list of templates from a file and generate a password for each template.

    -t TEMPLATE, --template TEMPLATE: Set a template for the password generation.

    -S SET, --set SET: Define a custom character set to use for password generation.

    -c COUNT, --count COUNT: Specify the number of passwords to generate. Default is 1.

    -v, --verbose: Enable verbose logging. More vs for more verbosity.

## Placeholder Information

The program uses placeholders to define the layout of the passwords. Here is a list of supported placeholders:

    d: Digit (0-9)

    l: Lower-case letter (a-z)

    L: Mixed-case letter (A-Z a-z)

    u: Upper-case letter (A-Z)

    p: Punctuation (.,;:)

    \: Escape (Fixed Char)

    {n}: Escape (Repeat)

    [...]: Custom Char Set

## Examples

# Generate a password of length 12:

python password_generator.py -n 12

# Generate a password using a template:

python password_generator.py -t "u{4}d{3}\-l{2}"
