# http://infohost.nmt.edu/~es421/pascal/list33.htm
# PROGRAM Determ
# the determinant of a 3-by-3 matrix
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

import numpy

def getData(): # get values for 3-by-3 array A
    N = 3
    A = [ [ 0 for i in range(N) ] for i in range(N) ]
    for I in range(N ):
        for J in range(N):
            print I + 1, ",", J + 1, ': ' ,
            A[I][J] = float(raw_input())
    for I in range(N):
        for J in range(N):
            print "%7.4f  " % (A[I][J]),
        print ""
    return A

def deter(A): # calculate the determinant of a 3-by-3 matrix
    Sum =       A[0][0]*(A[1][1]*A[2][2] - A[2][1]*A[1][2])
    Sum = Sum - A[0][1]*(A[1][0]*A[2][2] - A[2][0]*A[1][2])
    Sum = Sum + A[0][2]*(A[1][0]*A[2][1] - A[2][0]*A[1][1])
    return Sum

# main program
A = getData()
D = deter(A)
print "The determinant is ", D

# use built in Python function
D = numpy.linalg.det(A)
print "The determinant is ", D