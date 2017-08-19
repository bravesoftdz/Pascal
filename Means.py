# http://infohost.nmt.edu/~es421/pascal/list22.pas
# PROGRAM Means
# Find mean and standard deviation
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

import math
import numpy

# include MeanStd (Listing 2.1)
# but write as 2 separate functions:  Mean and Std

def Mean(X, N):
    SumX = 0.0
    for I in range(N):
        SumX = SumX + X[I]
    Mean = SumX/N
    return Mean

def Std(X, N):
    SumX = 0.0
    SumSq = 0.0
    for I in range(N):
        SumX = SumX + X[I]
        SumSq = SumSq + X[I]*X[I]
    StdDev = math.sqrt((SumSq - SumX**2/N)/(N - 1))
    return StdDev

# main program

X = []

print 'Calculation of mean and standard deviation'
N = int(raw_input(' How many points? '))
for I in range(1, N + 1):
    print I, ': ' ,
    x = float(raw_input())
    X.append(x)
print 'For ', N, ' points, mean =', Mean(X, N), ', sigma =', Std(X, N)

# use Python numpy functions for mean and standard deviation (using N - 1, not N)
print 'For ', N, ' points, mean =', numpy.mean(X), ', sigma =', numpy.std(X, ddof = 1)
