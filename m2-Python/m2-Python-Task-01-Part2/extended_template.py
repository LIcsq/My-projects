import logging
import random
import string


def extended_template(char):
    """
    Extended Template

    :param char: A single character representing the type of character to generate.
    :return: A randomly chosen character from the specified set.
    """
    # Initialize an empty password string
    password = ''

    # Check the template character and append a random character from the corresponding set
    if char == 'a':  # Lowercase letter or digit
        password += random.choice(string.ascii_lowercase + string.digits)
        logging.debug(f"{char} Adding lowercase letter or digit to template")

    elif char == 'A':  # Uppercase letter, lowercase letter, or digit
        password += random.choice(string.ascii_uppercase + string.ascii_lowercase + string.digits)
        logging.debug(f"{char} Adding uppercase letter, lowercase letter, or digit to template")

    elif char == 'U':  # Uppercase letter or digit
        password += random.choice(string.ascii_uppercase + string.digits)
        logging.debug(f"{char} Adding uppercase letter or digit to template")

    elif char == 'h':  # Hexadecimal digit (lowercase)
        password += random.choice(string.hexdigits.lower())
        logging.debug(f"{char} Adding hexadecimal digit (lowercase) to template")

    elif char == 'H':  # Hexadecimal digit (uppercase)
        password += random.choice(string.hexdigits.upper())
        logging.debug(f"{char} Adding hexadecimal digit (uppercase) to template")

    elif char == 'v':  # Vowel (lowercase)
        password += random.choice('aeiou')
        logging.debug(f"{char} Adding vowel (lowercase) to template")

    elif char == 'V':  # Vowel (any case)
        password += random.choice('AEIOUaeiou')
        logging.debug(f"{char} Adding vowel (any case) to template")

    elif char == 'b':  # Bracket
        password += random.choice('(){}[]<>')
        logging.debug(f"{char} Adding bracket to template")

    elif char == 'Z':  # Uppercase vowel
        password += random.choice('AEIOU')
        logging.debug(f"{char} Adding uppercase vowel to template")

    elif char == 'c':  # Consonant (lowercase)
        password += random.choice('bcdfghjklmnpqrstvwxyz')
        logging.debug(f"{char} Adding consonant (lowercase) to template")

    elif char == 'C':  # Consonant (any case)
        password += random.choice('bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXY')
        logging.debug(f"{char} Adding consonant (any case) to template")

    elif char == 'z':  # Uppercase consonant
        password += random.choice('BCDFGHJKLMNPQRSTVWXYZ')
        logging.debug(f"{char} Adding uppercase consonant to template")

    elif char == 'S':  # Printable character
        password += random.choice(string.printable)
        logging.debug(f"{char} Adding printable character to template")

    elif char == 's':  # Punctuation
        password += random.choice(string.punctuation)
        logging.debug(f"{char} Adding punctuation to template")

    elif char == 'x':  # Latin-1 Supplement character (excluding U+00AD)
        latin1_supplement = ''.join([chr(i) for i in range(0xA1, 0xAD)] + [chr(i) for i in range(0xAE, 0xFF + 1)])
        password += random.choice(latin1_supplement)
        logging.debug(f"{char} Adding Latin-1 Supplement character (excluding U+00AD) to template")

    # Return the generated password
    return password
