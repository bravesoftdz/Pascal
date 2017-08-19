# http://infohost.nmt.edu/~es421/pascal/list25.pas
# PROGRAM Rantst
# test Gaussian random-number generator Randg
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

import numpy
import random

from randg import randg # Listing 2.4

X = []
N = 50

print '    mean     std dev'
print '    (10)      (0.5)' 
print '   ===================='
for J in range(12):
    for I in range(N):
        X.append(randg(10, 0.5))
    Mean = numpy.mean(X)
    Std = numpy.std(X, ddof = 1)
    print '%10.4f %10.4f' % (Mean, Std)

# doesn't seem to be very random - many mean values < 10
# repeat but don't use 'randg' to see if the results look more random

print '    mean     std dev'
print '    (10)      (0.5)' 
print '   ===================='
for J in range(12):
    for I in range(N):
        X.append(random.normalvariate(10, 0.5))
    Mean = numpy.mean(X)
    Std = numpy.std(X, ddof = 1)
    print '%10.4f %10.4f' % (Mean, Std)
    
# still doesn't seem to be very random
