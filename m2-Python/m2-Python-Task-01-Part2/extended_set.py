import logging
import string


def extended_set(char):
    """
    Extended Set

    :param char: A single character representing the type of character to generate.
    :return: A randomly chosen set of characters from the specified set.
    """
    # Initialize an empty password string
    password = ''

    # Check the template character and append a random character from the corresponding set
    if char == 'a':  # Lowercase letter or digit
        password += string.ascii_lowercase + string.digits
        logging.debug(f"Added lowercase letters and digits to password: {password}")

    elif char == 'A':  # Uppercase letter, lowercase letter, or digit
        password += string.ascii_uppercase + string.ascii_lowercase + string.digits
        logging.debug(f"Added uppercase letters, lowercase letters, and digits to password: {password}")

    elif char == 'U':  # Uppercase letter or digit
        password += string.ascii_uppercase + string.digits
        logging.debug(f"Added uppercase letters and digits to password: {password}")

    elif char == 'h':  # Hexadecimal digit (lowercase)
        password += string.hexdigits.lower()
        logging.debug(f"Added hexadecimal digits (lowercase) to password: {password}")

    elif char == 'H':  # Hexadecimal digit (uppercase)
        password += string.hexdigits.upper()
        logging.debug(f"Added hexadecimal digits (uppercase) to password: {password}")

    elif char == 'v':  # Vowel (lowercase)
        password += 'aeiou'
        logging.debug(f"Added lowercase vowels to password: {password}")

    elif char == 'V':  # Vowel (any case)
        password += 'AEIOUaeiou'
        logging.debug(f"Added vowels (any case) to password: {password}")

    elif char == 'b':  # Bracket
        password += '(){}[]<>'
        logging.debug(f"Added brackets to password: {password}")

    elif char == 'Z':  # Uppercase vowel
        password += 'AEIOU'
        logging.debug(f"Added uppercase vowels to password: {password}")

    elif char == 'c':  # Consonant (lowercase)
        password += 'bcdfghjklmnpqrstvwxyz'
        logging.debug(f"Added lowercase consonants to password: {password}")

    elif char == 'C':  # Consonant (any case)
        password += 'bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ'
        logging.debug(f"Added consonants (any case) to password: {password}")

    elif char == 'z':  # Uppercase consonant
        password += 'BCDFGHJKLMNPQRSTVWXYZ'
        logging.debug(f"Added uppercase consonants to password: {password}")

    elif char == 'S':  # Printable character
        password += string.printable
        logging.debug(f"Added printable characters to password: {password}")

    elif char == 's':  # Punctuation
        password += string.punctuation
        logging.debug(f"Added punctuation to password: {password}")

    elif char == 'x':  # Latin-1 Supplement character (excluding U+00AD)
        latin1_supplement = ''.join([chr(i) for i in range(0xA1, 0xAD)] + [chr(i) for i in range(0xAE, 0xFF + 1)])
        password += latin1_supplement
        logging.debug(f"Added Latin-1 Supplement characters (excluding U+00AD) to password: {password}")

    # Return the generated password
    return password
