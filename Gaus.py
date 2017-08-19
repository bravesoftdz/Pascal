# http://infohost.nmt.edu/~es421/pascal/list42.pas
# PROGRAM Gaus
# simultaneous solution by Gaussian elimination
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

def getDataA(N): # Get values array A
    A = [ [ 0 for i in range(N) ] for i in range(N) ]
    for I in range(N):
        print 'Equation ', I + 1
        for J in range(N):
            print J + 1, ': ',
            A[I][J] = float(raw_input())
    print "A = ", A
    return A

def getDataY(N): # Get values for array Y
    Y = []
    for I in range(N):
        print 'C[', I + 1, '] = ',
        Y.append(float(raw_input()))
    print "Y = ", Y
    return Y

def writeData(M, coef): # print out the answers
    for I in range(M):
        print "%9.5f" % (coef[I]),
    print ""

def Gauss(A, Y, N):
    # matrix solution by Gaussian Elimination
    # Adapted from Gilder

    #I, J, I1, K, L, N: Integer
    #Hold, Sum, T, Ab, Big: Real

    Error = False
    #N = Ncol
    
    B = [ [ 0 for i in range(N) ] for i in range(N) ] # work array
    W = [] # work array
    # copy to work arrays
    for I in range(N):
        for J in range(N):
            B[I][J] = A[I][J]
        W.append(Y[I])
 
    for I in range(N - 1):
        Big = abs(B[I][I])
        L = I
        I1 = I + 1
        for J in range(I1, N): # search for largest element - use "N + 1"?
            Ab = abs(B[J][I])
            if Ab > Big:
                Big = Ab
                L = J
        if Big == 0.0: 
            Error = True
        else:
            if L != I: # interchange rows to put largest element on diagonal
                for J in range(N):
                    Hold = B[L][J]
                    B[L][J] = B[I][J]
                    B[I][J] = Hold
                Hold = W[L]
                W[L] = W[I]
                W[I] = Hold
            for  J in range(I1, N):
                T = B[J][I]/B[I][I]
                for K in range(I1, N): # use 'N + 1'?
                    B[J][K] = B[J][K] - T*B[I][K]
                W[J] = W[J] - T*W[I]
  
    if B[N][N] == 0.0: 
        Error = True
    else:
        Coef[N] = W[N]/B[N][N]
        I = N - 1
        while I != 0: # back substitution
            Sum = 0.0
            for J in range(I + 1, N): # use 'N + 1'?
                Sum = Sum + B[I][J]*Coef[J]
            Coef[I] = (W[I] - Sum)/B[I][I]
            I = I - 1

    if Error: 
        print 'ERROR: Matrix singular'
    else:
        writeData(N, coef)

# main program
print 'Simultaneous solution by Gauss elimination'
N = int(raw_input('How many equations (2-8)?'))
A = getDataA(N)
Y = getDataY(N)
Gauss(A, Y, Coef, N)
