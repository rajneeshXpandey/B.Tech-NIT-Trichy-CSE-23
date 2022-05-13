"""
106119100 Rajneesh Pandey

Differential Cryptanalysis of SPN
"""


# SBox function: n in an integer between 0 and 15

def SBox(n):
    val = hex(n)
    if val == '0x0':
        return int(0xe)
    elif val == '0x1':
        return int(0x4)
    elif val == '0x2':
        return int(0xd)
    elif val == '0x3':
        return int(0x1)
    elif val == '0x4':
        return int(0x2)
    elif val == '0x5':
        return int(0xf)
    elif val == '0x6':
        return int(0xb)
    elif val == '0x7':
        return int(0x8)
    elif val == '0x8':
        return int(0x3)
    elif val == '0x9':
        return int(0xa)
    elif val == '0xa':
        return int(0x6)
    elif val == '0xb':
        return int(0xc)
    elif val == '0xc':
        return int(0x5)
    elif val == '0xd':
        return int(0x9)
    elif val == '0xe':
        return int(0x0)
    elif val == '0xf':
        return int(0x7)


def PBox(n):  # Implementation of the PBox function. Again, n in an integer between 0 and 15

    val = n + 1
    retval = 0
    if val == 1:
        retval = 1
    elif val == 2:
        retval = 5
    elif val == 3:
        retval = val+6
    elif val == 4:
        retval = (val+9)
    elif val == 5:
        retval = val-3
    elif val == 6:
        retval = val
    elif val == 7:
        retval = val+3
    elif val == 8:
        retval = (val + 6)
    elif val == 9:
        retval = (val-6)
    elif val == 10:
        retval = (val-3)
    elif val == 11:
        retval = val
    elif val == 12:
        retval = (val+3)
    elif val == 13:
        retval = (val-9)
    elif val == 14:
        retval = (val-6)
    elif val == 15:
        retval = (val-3)
    elif val == 16:
        retval = val

    return retval-1


# takes an integer between 0 and 15 as input and converts it to an array of zeroes and ones, representing the binary notation of that number
def convertBin(n):  
    p = format(n, '#06b')
    p = p[2:]
    p = [int(x) for x in p]
    return p


# takes an array of size 4 of zeroes and ones, and converts it to integer
def BackToInt(l):  
    r = 0
    for item in l:
        r = (r << 1) | item
    return r


# takes an integer x' in [0, 15] as input, and calculates all possible x*'s corresponding to x's in [0, 15]
def DeltaX(xp):
    delX = []
    for i in range(16):
        delX.append(i ^ xp)
    return delX


"""
Substitution- Permutation network 
"""


class SPN:

    K = [[], [], [], [], []]  # 5 round keys for an SPN of 4 rounds
    Key = [3, 10, 9, 4, 13, 6, 3, 15]  # the 32-bit key of the SPN
    U = [[], [], [], []]
    V = [[], [], [], []]
    W = [[], [], []]
    Y = []  # SPN output
    _X = []  # SPN input

# The following lists have been initialised just for the ease of calculation, and are not relevent since they do not correspond to any significant SPN property
    u = []
    v = []
    w = []
    v_w = []

    # calculates u_r for the round r, given the value of w_{r-1}
    def calcU(self, r, w_r_):
        u = []
        for j in range(len(w_r_)):
            u.append(w_r_[j] ^ self.K[r][j])
        self.U[r] = u

    def calcV(self, r, u_r):  # calculates v_r for the round r, given the value of u_r
        v = []
        for j in range(len(u_r)):
            v.append(SBox(u_r[j]))
        self.V[r] = v

    def calcW(self, r, v_r):  # calculates w_r for the round r, given the value of v_r
        w = []
        v_w = []
        for v in v_r:
            # We have represented all the 16-bit SPN parameters as an array of 4 integers in [0, 15].
            # But to calculate w, we need all the 16 bits. Hence, here the required conversion is done

            v_w.append(convertBin(v))

        w_row = []
        for j in range(4):
            k = j*4
            for m in range(k, k+4):
                w_row.append(v_w[int(PBox(m)/4)][PBox(m) % 4])
            w.append(w_row)
            w_row = []
        for j in range(4):
            w[j] = BackToInt(w[j])

        self.W[r] = w

    def calcY(self):  # calculates the output Y of the SPN
        y = []
        l = len(self.V)
        k = len(self.K)
        for j in range(len(self.V[l-1])):
            y.append(self.V[l-1][j] ^ self.K[4][j])
        self.Y = y

    def __init__(self, X):
        """
        #Initialises the SPN using the given input X. 
        We expect a list conataining a single list of size 4  
        """
        for i in range(5):  # Generates 5 round keys for the SPN of 4 rounds
            rkey = []
            for j in range(i, i+4):
                rkey.append(self.Key[j])
            self.K[i] = rkey

        for x in X:  # This loop runs only for one iteration since X contains just one element
            self._X = x
            if len(x) != len(self.K[1]):
                print("invalid input")
                pass
            else:
                """
                        Since we are using arrays here, we are forced to used zero-indexing.
                        So, here U0 will denote the SBox inputs for the first round.
                        This also means that W0 here is the actual W1. 
                        Instead of creating an actual W0, we've directly calculated the actual U1's using the input X
                """
                for i in range(0, 4):
                    if i == 0:
                        self.calcU(i, x)
                    else:
                        self.calcU(i, self.W[i-1])

                    self.calcV(i, self.U[i])

                    if i != 3:  # Calculate W's except for the last round
                        self.calcW(i, self.V[i])
                    else:
                        self.calcY()

    def display(self):  # function that displays all the SPN parameters, over all the 4 rounds
        K0_disp = []
        K1_disp = []
        K2_disp = []
        K3_disp = []
        K4_disp = []
        W_disp = []
        V_disp = []
        U_disp = []
        Y_disp = []
        X_disp = []

        for i in range(4):
            K0_disp.append(convertBin(self.K[0][i]))
            K1_disp.append(convertBin(self.K[1][i]))
            K2_disp.append(convertBin(self.K[2][i]))
            K3_disp.append(convertBin(self.K[3][i]))
            K4_disp.append(convertBin(self.K[4][i]))

        for w in self.W:
            w_d = []
            for i in range(len(w)):
                w_d.append(convertBin(w[i]))
            W_disp.append(w_d)

        for u in self.U:
            u_d = []
            for i in range(len(u)):
                u_d.append(convertBin(u[i]))
            U_disp.append(u_d)

        for v in self.V:
            v_d = []
            for i in range(len(v)):
                v_d.append(convertBin(v[i]))
            V_disp.append(v_d)

        y_d = []
        for y in self.Y:
            y_d.append(convertBin(y))
        Y_disp.append(y_d)

        x_d = []
        for x in self._X:
            x_d.append(convertBin(x))
        X_disp.append(x_d)

        for w in W_disp:
            print("W is", w)

        for w in U_disp:
            print("U is", w)

        for w in V_disp:
            print("V is", w)

        for w in Y_disp:
            print("Y is", w)

        print("K[0] is ", K0_disp)
        print("K[1] is ", K1_disp)
        print("K[2] is ", K2_disp)
        print("K[3] is ", K3_disp)
        print("K[4] is ", K4_disp)

################################################## The Differential Attack ###################################################


def DiffAttack(T, Pi_inv):
    """
            In this function, the tuple T consists of two objects of the SPN class, one corresponding to the input x 
            and other corresponding to the input x*
            We assume no access to any parameter of the SPN, except the input x and the output y. 
    """
    count = []

    for l1 in range(0, 16):
        """
        We want to find the 8-bit candidate key for a given differential trail. This 8-bit candidate forms half of the key in round 5
        """
        countRow = []
        for l2 in range(0, 16):
            countRow.append(0)
        count.append(countRow)

    for [sp, sp_] in T:
        x = sp._X
        x_ = sp_._X
        y = sp.Y
        y_ = sp_.Y
        u42 = 0
        u42_ = 0
        u44 = 0
        u44_ = 0
        if y[0] == y_[0] and y[2] == y_[2]:
            for l1 in range(0, 16):
                for l2 in range(0, 16):
                    v42 = l1 ^ y[1]
                    v44 = l2 ^ y[3]
                    u42 = Pi_inv[v42]
                    u44 = Pi_inv[v44]
                    v42_ = l1 ^ y_[1]
                    v44_ = l2 ^ y_[3]
                    u42_ = Pi_inv[v42_]
                    u44_ = Pi_inv[v44_]
                    u42Prime = u42 ^ u42_
                    u44Prime = u44 ^ u44_
                    if u42Prime == 0b0110 and u44Prime == 0b0110:
                        count[l1][l2] = count[l1][l2] + 1

    _max = -1

    print("\nThe candidate keys with their probabilities are (count, probability, l1, l2)")
    for l1 in range(0, 16):
        for l2 in range(0, 16):
            if count[l1][l2] > _max:
                _max = count[l1][l2]
                print(_max, float(_max/256.0), l1, l2)
                maxkey = [l1, l2]

    maxkey_disp = [bin(maxkey[0]), bin(maxkey[1])]
    print("\nHence the most probable key candidates for S42 and S44 are:")
    print(maxkey)

    print("The original key for the final round(K5) is:")
    print(sp.K[len(sp.K) - 1])
    print("\n Congratulations!!! The Differential Attack was successful")


##################### FINAL Algorithm ################################
X_prime = []

for i in range(0, 16):
    X_prime.append(i)

DeltaX_ = []  # A 2d array, such that DeltaX_[x'][x] = x*
X = []
for i in range(0, 16):
    DeltaX_.append(DeltaX(i))

for i in range(0, 16):
    X.append(i)

XStar = []

for x in X:
    x_starRow = []
    for xp in X_prime:
        x_starRow.append(DeltaX_[x][xp])
    XStar.append(x_starRow)

Y = []
YStar = []

for x_ in X:
    Y.append(SBox(x_))


for x_ in XStar:
    yrow = []
    for j in range(16):
        yrow.append(SBox(x_[j]))
    YStar.append(yrow)

Y_Prime = []

for y in YStar:
    yrow = []
    for j in range(16):
        yrow.append(Y[j] ^ y[j])
    Y_Prime.append(yrow)

b_prime = []

for y in Y_Prime:
    brow = []
    for i in range(16):
        c = y.count(i)
        brow.append(c)
    b_prime.append(brow)


Nd = []
for b in b_prime:
    ndrow = []
    for j in range(16):
        ndrow.append(float(b[j]))
    Nd.append(ndrow)


def Rp(i, j):  # Function that calculates the propogation ratio
    return(Nd[i][j]/16)


Pi_inv = {0: 0}  # Dictionary that stores the inverse SBox values

for i in range(0, 16):
    Pi_inv[SBox(i)] = i


INP = []  # x
for i in range(16):
    for j in range(16):
        for k in range(16):
            INP.append([0, i, j, k])

sp = []  # array of SPN's for all possible values x

for i in range(len(INP)):
    sp.append(SPN([INP[i]]))

INP1 = []  # x*
for i in range(16):
    for j in range(16):
        for k in range(16):
            INP1.append([0, DeltaX_[11][i], DeltaX_[0][j], DeltaX_[0][k]])

sp1 = []  # array of SPN's for all possible values of x*
for i in range(len(INP1)):
    sp1.append(SPN([INP1[i]]))

OP = []  # y
for i in range(len(INP)):
    OP.append(sp[i].Y)


OP1 = []  # y*
for i in range(len(INP1)):
    OP.append(sp1[i].Y)

T = []  # Tuples to be used in the Differential Attack
for i in range(len(sp)):
    T.append([sp[i], sp1[i]])

print("The dataset size is: ",  len(INP))  # Size of the input dataset


def calcMaxProbV(x):  # Returns the value that is most likely to occur looking at the propogation ratios for a given value of x
    prob = []
    retval = 0
    for i in range(16):
        prob.append(Rp(x, i))

    retval = prob.index(max(prob))
    return [retval, max(prob)]


testsp = SPN([[0, 11, 0, 0]])  # Constant x' is 0000 1011 0000 0000

print("\nThe Differential Trail: ")
p = 0
for i in range(3):
    if i == 0:
        testsp.U[i] = testsp._X
        arr = testsp.U[i]
        for j in range(len(arr)):
            testsp.V[i][j] = calcMaxProbV(arr[j])[0]
            if arr[j] != 0:
                p = calcMaxProbV(arr[j])[1]
            # print(p)

        testsp.calcW(i, testsp.V[i])
    else:
        testsp.U[i] = testsp.W[i-1]
        arr = testsp.U[i]
        for j in range(len(arr)):
            testsp.V[i][j] = calcMaxProbV(arr[j])[0]
            if arr[j] != 0:
                p *= calcMaxProbV(arr[j])[1]

        if i != 3:
            testsp.calcW(i, testsp.V[i])

    print("Round", i+1, "U", testsp.U[i])
    print("Round", i+1, "V", testsp.V[i])
    if i != 3:
        print("Round", i+1, "W", testsp.W[i])
    print("probability", p)

DiffAttack(T, Pi_inv)
