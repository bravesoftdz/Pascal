# http://infohost.nmt.edu/~es421/pascal/list41.htm
# PROGRAM Simq1
# Three simultaneous equations by Cramer's rule
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

def getDataA(N): # Get values array A
    A = [ [ 0 for i in range(N) ] for i in range(N) ]
    for I in range(N):
        print 'Equation ', I + 1
        for J in range(N):
            print J + 1, ': ',
            A[I][J] = float(raw_input())
    return A
    
def getDataY(N): # Get values for array Y
    Y = []
    for I in range(N):
        print 'C[', I + 1, '] = ',
        Y.append(float(raw_input()))
    return Y

def writeData(A, Y, coeff): # print out the answers
    for I in range(N):
        for J in range(N):
            print '%7.4f  ' % (A[I][J]),
        print ' : %7.4f' % (Y[I])
    print ""
    for I in range(N):
        print "%9.5f" % (coeff[I]),
    print ""

def deter(A): # calculate the determinant of a 3-by-3 matrix
    Sum =       A[0][0]*(A[1][1]*A[2][2] - A[2][1]*A[1][2])
    Sum = Sum - A[0][1]*(A[1][0]*A[2][2] - A[2][0]*A[1][2])
    Sum = Sum + A[0][2]*(A[1][0]*A[2][1] - A[2][0]*A[1][1])
    return Sum

def setup(A, Y, det, N, Column):
    B = [ [ 0 for i in range(N) ] for i in range(N) ]
    for I in range(N):
        for J in range(N):
            B[I][J] = A[I][J]
    for I in range(N):
        B[I][Column] = Y[I]
    detB = deter(B)
    coefficient = detB/det
    return coefficient

def solve(A, Y, N):
    coeff = []
    det = deter(A)
    if det == 0.0:
        print 'ERROR: matrix singular'
    else:
        coeff.append(setup(A, Y, det, N, 0))
        coeff.append(setup(A, Y, det, N, 1))
        coeff.append(setup(A, Y, det, N, 2))
        writeData(A, Y, coeff)

# main program
print 'Simultaneous solution by Cramers rule'
N = 3
A = getDataA(N)
Y = getDataY(N)
solve(A, Y, N)
