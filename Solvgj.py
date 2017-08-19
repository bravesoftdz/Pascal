# http://infohost.nmt.edu/~es421/pascal/list43.pas
# PROGRAM Solvgj
# simultaneous solution by Gauss-Jordan elimination
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

from Gaussj import Gaussj # Listing 4.4

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

# main program
print 'Simultaneous solution by Gauss-Jordan elimination'
N = int(raw_input('How many equations (2-8)?'))
A = getDataA(N)
Y = getDataY(N)
for I in range(N):
    for J in range(N):
        B[I][J] = A[I][J] # Setup work array
Gaussj(B, Y, Coef, N, Error)
IF NOT Error:
    writeData
