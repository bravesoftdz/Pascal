# http://infohost.nmt.edu/~es421/pascal/square.htm
# PROCEDURE Square
# matrix multiplication routine
# A = transpose X times X
# G = Y times X
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

def MatSquare(X, Nrow, Ncol):
    A = [ [ 0 for i in range(Ncol) ] for i in range(Ncol) ]
    for K in range(Ncol):
        for L in range(0, K + 1):
            for I in range(Nrow):
                A[K][L] += X[I][L]*X[I][K]
                if K != L:
                    A[L][K] = A[K][L]
    return A

def MatMult(X, Y, Nrow, Ncol):
    G = [0 for i in range(Ncol)]
    for K in range(Ncol):
        for I in range(Nrow):
            G[K] += Y[I]*X[I][K]
    return G


