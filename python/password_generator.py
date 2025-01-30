#  Python script to generate complex 15 digits passwords

import random
import string

def generate_complex_password():
    upper = string.ascii_uppercase
    lower = string.ascii_lowercase
    digits = string.digits
    special = '#$@!?'
    
    pattern = [
        random.choice(upper),
        random.choice(lower),
        random.choice(digits),
        random.choice(special),
        random.choice(lower),
        random.choice(upper),
        random.choice(special),
        random.choice(lower),
        random.choice(digits),
        random.choice(lower),
        random.choice(upper),
        random.choice(digits),
        random.choice(special),
        random.choice(lower),
        random.choice(digits)
    ]
    
    return ''.join(pattern)

# Generate 5 passwords
for _ in range(5):
    print(generate_complex_password())