import string
import random
import re
import logging
from extended_template import extended_template
from set import set_generator


def handle_escape(match):
    """
    Handle custom characters in the template.

    :param match: Match object containing the escape character.
    :return: The escaped character.
    """
    custom_set = set_generator(match.group(1))
    logging.warning("Be careful, using custom set in password can reduce password strength")
    logging.debug(f"Using custom set {custom_set}")
    custom_set = ''.join(random.choices(custom_set, k=len(match.group(1))))
    return custom_set


def check_template(template):
    """
    Generate a password based on a template.

    :param template: Template string defining the password layout.
    :return: Generated password as a string.
    """

    # Initialize password
    password = ''

    # Define character sets
    digit_set = string.digits
    lower_set = string.ascii_lowercase
    upper_set = string.ascii_uppercase
    punctuation_set = ',.;:'

    # Compile regex patterns
    custom_set_pattern = re.compile(r'\[(.*?)\]')
    repeat_pattern = re.compile(r'\{(\d+)\}')

    # Function to handle repeat placeholders
    def repeat_placeholders(match):
        pattern = ''
        repeat_count = int(match.group(1))
        if re.findall(custom_set_pattern, template):

            # Find all substrings inside square brackets and join them into a single string
            substrings = set_generator(''.join(re.findall(r'\[(.*?)\]', template)))
            # Use random.choices to select characters from the combined substrings
            pattern = ''.join(random.choices(substrings, k=repeat_count))

        else:
            previous_char = template[match.start() - 1]
            for _ in range(repeat_count - 1):
                pattern += previous_char
            logging.debug(f"Multiply {previous_char} {repeat_count} times")
        return pattern

    # Handle repeat placeholders in the template
    if re.findall(repeat_pattern, template):
        temp = repeat_placeholders(repeat_pattern.search(template))
        password += temp
        template = ''.join(char for char in temp if char not in temp)
    elif re.findall(custom_set_pattern, template):
        temp = custom_set_pattern.sub(handle_escape, template)
        password += temp
        template = ''.join(char for char in template if char not in temp)

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
            logging.debug(f"Using \\ in template")
            slash_pattern = True
        else:
            password += extended_template(char)

    return password
