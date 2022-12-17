import hmac
import hashlib
import base64
import hashlib
import socket
#Define function that appends the message into a byte-array of length = to padded variable
def pad_append(padded):
    byte_arr = bytearray(padded for i in range(padded))
    return byte_arr

#initialize the buffer to 0
def init_buffer(buffer_X):
    byte_arr = bytearray(0 for i in range(buffer_X))
    return byte_arr

# xor function
def xor(x, y):
    x = str(x).encode()
    y = str(y).encode()
    return (bytes(x[i] ^ y[i] for i in range(min(len(x), len(y)))))


def custom_hash(inputs):
    S = [217,234,107,151,40,124,238,73,7,131,84,181,0,190,125,105,143,161,31,241,84,203,137,161,53,5,191,187,110,206,170,146,3,138,2,203,50,2,174,97,61,171,47,150,17,201,181,117,16,61,171,230,137,2,134,8,212,145,193,41,43,92,19,226,16,6,112,235,204,38,94,89,50,23,95,24,129,138,137,228,29,131,45,59,155,201,192,40,34,114,61,114,6,76,104,121,53,32,115,234,10,150,232,42,78,222,98,254,75,248,11,63,120,114,139,56,238,198,187,200,19,4,131,176,93,1,46,60,13,47,185,29,37,143,204,241,87,83,225,146,177,176,148,33,112,24,41,71,62,230,238,44,148,132,197,40,189,58,65,66,199,239,45,227,135,240,6,115,208,41,85,204,180,240,85,83,182,48,214,199,39,152,115,83,89,136,96,63,67,243,49,119,31,200,190,79,64,220,127,189,227,45,34,136,127,77,26,169,24,122,105,162,46,104,47,33,145,159,185,117,52,189,95,214,39,194,94,35,77,192,78,205,87,127,204,123,184,136,3,43,67,72,239,102,233,252,25,173,97,137,210,36,12,3,100,63]
    #Convert input(string) into a bytearray in utf-8 formatting
    M = bytearray(str(inputs), 'utf-8')
    x = 16
    padded = x - (len(M) % 16)
    
    #we add padding to the message to ensure that we have full blocks
    M = M + pad_append(padded)
    L = 0
    buffer_X = 48


    buffer = init_buffer(buffer_X)
    # ### PROCESS MESSAGE IN 16-BYTE BLOCKS and process each 16-byte block for the buffer of 48
    for i in range(len(M) // x):
        for j in range(x):
            buffer[2 * x + j] = buffer[x + j] ^ buffer[j]
            buffer[x + j] = M[i * x + j]
        
        #initialize t = 0
        t = 0
        
        #perform 5 rounds of iteration
        rounds = 5
        for j in range(rounds):
            for k in range(buffer_X):
                buffer[k] = buffer[k] ^ S[t]
                t = buffer[k]
            t = (t + j) % len(S)

    #the function outputs a 32-byte output thus we are using zfill(2) as the hex() function defaults by not providing the leading 0 
    for i in buffer[0:16]:
        output = ''.join(map(lambda x: hex(x).zfill(2).lstrip("0x"), buffer[0:16]))
    tempo = hashlib.sha1(output.encode())
    tempo.update(output.encode())
    return tempo


def hmac(key_K, data):
    if len(key_K) > 64:
        raise ValueError('The key must be <= 64 bytes in length')
    padded_K = key_K + b'\x00' * (64 - len(key_K))
    ipad = b'\x36' * 64
    opad = b'\x5c' * 64
    
    h_inner = custom_hash(xor(padded_K, ipad))
    h_inner.update(data)
    h_outer = custom_hash(xor(padded_K, opad))
    h_outer.update(h_inner.digest())
    buffer = h_outer.digest()
    for i in buffer[0:16]:
        output = ''.join(map(lambda x: hex(x).zfill(2).lstrip("0x"), buffer[0:16]))
    return output



def integrity_test():
    # test 1
    message1 = b"/pi/embedded_dashboard?data=%7B%22dashboard%22%3A7863%2C%22embed%22%3A%22v2%22%2C%22filters%22%3A%5B%7B%22name%22%3A%22Filter1%22%2C%22value%22%3A%22value1%22%7D%2C%7B%22name%22%3A%22Filter2%22%2C%22value%22%3A%221234%22%7D%5D%7D"
    message2 = b"data=%7B%22dashboard%22%3A7863%2C%22embed%22%3A%22v2%22%2C%22filters%22%3A%5B%7B%22name%22%3A%22Filter1%22%2C%22value%22%3A%22value1%22%7D%2C%7B%22name%22%3A%22Filter2%22%2C%22value%22%3A%221234%22%7D%5D%7D"

    key = b"e279"
    result1 = hmac(key, message1)
    result2 = hmac(key, message2)
    print("Message 1 : ",  message1, end="\n\n")
    print("HMAC Digest : ")
    print(result1, end="\n\n")
    print("Message 2 : ",  message2, end="\n\n")
    print("HMAC Digest : ")
    print(result2, end="\n\n")
    if result1 == result2:
        print("Integrity test failed!!!!")
    else:
        print("Integrity test passed!")
    
    # add tests as desired




