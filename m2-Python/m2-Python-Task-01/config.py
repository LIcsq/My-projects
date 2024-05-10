import string
'''
Config module consist of characters_set that will 
be used in password generation
'''
char_set = {
    'd': string.digits,
    'l': string.ascii_lowercase,
    'u': string.ascii_uppercase,
    'p': ',.;:',
}
