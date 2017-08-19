# http://infohost.nmt.edu/~es421/pascal/list23.pas
# PROGRAM Rantst
# test random-number generator Random
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

import numpy

X = []
N = 48

print '    mean     std dev'
print '    (0.5)    (0.2887)'
print '   ===================='
for J in range(12):
	for I in range(N):
    	X[I] = Random
	Mean = numpy.mean(X)
	Std = numpy.std(X, ddof = 1)
	print '%10.4f %10.4f' % (Mean, Std)
