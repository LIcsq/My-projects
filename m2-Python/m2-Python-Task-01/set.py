import string
import random
import re
import logging

def handle_escape(match):
    """
    Handle escape characters in the input set.

    :param match: Match object containing the escape character.
    :return: The escaped character.
    """
    return match.group(1)

def set_generator(input_set, length):
    """
    Generate a password using a custom character set.

    :param input_set: Custom character set or pattern.
    :param length: Length of the password to be generated.
    :return: Generated password as a string.
    """

    # Define character sets
    digit_set = string.digits
    lower_set = string.ascii_lowercase
    upper_set = string.ascii_uppercase
    punctuation_set = string.punctuation

    # Log the input set
    logging.debug(f'Input set: {input_set}')

    # Handle escape characters
    input_set = re.sub(r'\\(.)', handle_escape, input_set)

    # Handle exclusion of certain symbols from the set
    if '^' in input_set:
        custom_set, exclude_set = input_set.split('^', 1)
        logging.debug(f"Symbols to exclude from set: {exclude_set}")
        digit_set = ''.join(char for char in digit_set if char not in exclude_set)
        lower_set = ''.join(char for char in lower_set if char not in exclude_set)
        upper_set = ''.join(char for char in upper_set if char not in exclude_set)
        punctuation_set = ''.join(char for char in punctuation_set if char not in exclude_set)
        input_set = custom_set

    # Generate the set based on the input set
    generated_set = ''
    custom_set = set(input_set)
    for char in custom_set:
        if char == 'd':
            generated_set += digit_set
            logging.debug(f"{char} Using digit_set")
        elif char == 'l':
            generated_set += lower_set
            logging.debug(f"{char} Using lower_case set")
        elif char == 'L':
            generated_set += lower_set + upper_set
            logging.debug(f"{char} Using mixed_char_set ")
        elif char == 'u':
            generated_set += upper_set
            logging.debug(f"{char} Using upper_char_set ")
        elif char == 'p':
            generated_set += punctuation_set
            logging.debug(f"{char} Using punctuation_set")
        elif char == '\\':
            generated_set += handle_escape(char)
        elif char == '{':
            logging.warning(f"{char} Set supports only d,l,p,L,^,\ placeholder. Use --help for more information")
        else:
            logging.warning(f"{char} is not in the admissible set. It will be ignored")

    # Check if the generated set is smaller than the desired length
    if len(generated_set) < length:
        logging.warning(f"The length: {length} is smaller than length of the generated set. This can reduce password strength")


    # Log the generated set
    logging.debug(f"Final set: {generated_set}")

    # Generate the password using the generated set
    password = ''.join(random.choices(generated_set, k=length))

    return password