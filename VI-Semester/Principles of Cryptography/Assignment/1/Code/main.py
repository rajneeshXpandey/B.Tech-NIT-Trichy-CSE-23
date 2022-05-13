import ctypes
from pwn import *
#import pwn
import json
from cypari import pari

# Connect to server
context.log_level = 'error'
sh = remote('localhost', 8000)


# Receive N
N = int(sh.recvuntil(b'\n'))
print("N: ", N)

# Compute the two primfactors using cypari
factors = pari.factor(N)
p = int(factors[0][0])
q = int(factors[0][1])
print("Prime factors are p={} and q={}".format(p, q))

# The jacobi symbol is a generalization of the Legendre symbol which we could also use here
# For the jacobi symbol (a,p) we have the definition:
# 0 - if a = 0 mod(p)
# 1  if a != 0 mod(p) and a is a quadratic residue
# -1 if a 1= 0 mod(p) and a is a quadratic non-residue

# Now that we have p and q, we can decrypt the bits as using the jacobi symbol to check if the encoded bit is a quadratic
# residue of mod n.
# If the jacobi symbol for an encrypted bit is 1, then we know that the decrypted bit is 0
# If the jacobi symbol for an encrypted bit is -1, then we know that the decrypted bit is 1
# It will never be 0 due to the way that we calculate the encryption


def jacobi(a, n):
    if a == 0:
        return 0
    if a == 1:
        return 1

    e = 0
    a1 = a
    while a1 % 2 == 0:
        e += 1
        a1 = a1 // 2
    assert 2 ** e * a1 == a

    s = 0

    if e % 2 == 0:
        s = 1
    elif n % 8 in {1, 7}:
        s = 1
    elif n % 8 in {3, 5}:
        s = -1

    if n % 4 == 3 and a1 % 4 == 3:
        s *= -1

    n1 = n % a1

    if a1 == 1:
        return s
    else:
        return s * jacobi(n1, a1)


# we compute both strings and throw away the empty one
p_string = ""
q_string = ""

# From the source code, we know that we expect a message of length 20
for i in range(20):
    p_list = []
    q_list = []

    # Receive the token from the server and turn into a list of encoded bits
    token = sh.recvuntil(b'\n').decode('utf-8')
    print(token)
    j_text = token.replace(' ', ',')
    bit_enc_list = json.loads(j_text)

    # Compute the Jacobi symbol for each bit
    for bit_enc in bit_enc_list:
        # Encoded bit is 0 if jacobi(b, q) == 1 if it is -1, it is 0
        # Basically this is checking if c**((p-1)/2) is congruent to 1 mod p (and c**((q-1)/2) is congruent to 1 mod q)
        bit_p = 1 if jacobi(bit_enc, p) == -1 else 0
        bit_q = 1 if jacobi(bit_enc, q) == -1 else 0

        p_list.append(bit_p)
        q_list.append(bit_q)

    # Turn the bit array into an int
    p_int = int("".join(str(i) for i in p_list), 2)
    q_int = int("".join(str(i) for i in q_list), 2)

    # and the int into a char which we append to the string
    p_string = p_string + chr(p_int)
    q_string = q_string + chr(q_int)

# Throw away the empty string and send the decoded string to the server
if not p_string[0] == '\x00':
    msg = p_string.format()
else:
    msg = q_string.format()

print('Decoded string: {}'.format(msg))
sh.sendline(msg.encode('utf-8'))

# Receive empty line before our flag
sh.recvuntil(b'\n')
flag = sh.recvuntil(b'\n')
print(flag.decode('utf-8'))
