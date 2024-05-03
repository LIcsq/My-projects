import string
import random
import re
import logging

def handle_escape(match):
    """
    Handle escape characters in the template.

    :param match: Match object containing the escape character.
    :return: The escaped character.
    """
    logging.warning("Be careful, using custom set in password can reduce password strength")
    logging.debug(f"Using custom set {match.group(1)}")
    return match.group(1)

def check_template(template):
    """
    Generate a password based on a template.

    :param template: Template string defining the password layout.
    :return: Generated password as a string.
    """
    # Define character sets
    digit_set = string.digits
    lower_set = string.ascii_lowercase
    upper_set = string.ascii_uppercase
    punctuation_set = string.punctuation

    # Compile regex patterns
    custom_set_pattern = re.compile(r'\[(.*?)\]')
    repeat_pattern = re.compile(r'\{(\d+)\}')

    # Initialize password
    password = ''

    # Function to handle repeat placeholders
    def repeat_placeholders(match):
        repeat_count = int(match.group(1))
        previous_char = template[match.start()-1]
        pattern = ''
        logging.debug(f"Multiply {repeat_count} {previous_char} times")
        for i in range(repeat_count-1):
            pattern += previous_char
        return pattern

    # Handle repeat placeholders in the template
    template = repeat_pattern.sub(repeat_placeholders, template)

    # Handle custom set patterns in the template
    template = custom_set_pattern.sub(handle_escape, template)


    slash_pattern = False
    # Generate the password based on the template
    for char in template:
        if slash_pattern is True:
            password += char
            logging.debug(f" '{char}' Adding character to template."
                          f"Be careful, using custom char in password can reduce password strength")
            slash_pattern = False
            continue
        if char == 'd':
            password += random.choice(digit_set)
            logging.debug(f"{char} Adding digit char to template")
        elif char == 'l':
            password += random.choice(lower_set)
            logging.debug(f"{char} Adding lower_case char to template ")
        elif char == 'L':
            password += random.choice(lower_set + upper_set)
            logging.debug(f"{char} Adding Mixed-Case letter  to template ")
        elif char == 'u':
            password += random.choice(upper_set)
            logging.debug(f"{char} Adding Upper_case char to template ")
        elif char == 'p':
            password += random.choice(punctuation_set)
            logging.debug(f"{char} Using punctuation char")
        elif char == '\\':
            logging.warning(f"Using \\ in template")
            slash_pattern = True
        else:
            logging.warning(f"{char} is not in the admissible set. It will be ignored")
    return password