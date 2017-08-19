# http://infohost.nmt.edu/~es421/pascal/list31.pas
# PROGRAM Matr1
# matrix multiplication
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

from square import MatSquare # Listing 3.2
from square import MatMult # Listing 3.2

def getDataX(Nrow, Ncol):  # get values array X
    X = [ [ 0 for i in range(Ncol) ] for i in range(Nrow) ]
    for I in range(Nrow):
        X[I][0] = 1
        for J in range(1, Ncol):
            X[I][J] = (I + 1)*X[I][J - 1]
    return X

def getDataY(Nrow):  # get values for array Y
    Y = []
    for I in xrange(Nrow):
        Y.append(2*(I + 1))
    return Y

def writeData(X, Y, A, G, Nrow, Ncol):  # print out the answers
    print '               X                      Y'
    for I in range(Nrow):
        for J in range(Ncol):
            print '%7.1f  ' % (X[I][J]),
        print ' : %7.1f' % (Y[I])
    print '               A                      G'
    for I in range(Ncol):
        for J in range(Ncol):
            print '%7.1f  ' % (A[I][J]),
        print ' : %7.1f' % (G[I])

# main program

Nrow = 5
Ncol = 3

X = getDataX(Nrow, Ncol)
Y = getDataY(Nrow)
A = MatSquare(X, Nrow, Ncol)
G = MatMult(X, Y, Nrow, Ncol)
writeData(X, Y, A, G, Nrow, Ncol)