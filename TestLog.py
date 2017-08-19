# http://infohost.nmt.edu/~es421/pascal/list12.pas
# PROGRAM Tlog
# test ln and exp 
# From Borland Pascal Programs for Scientists and Engineers 
# by Alan R. Miller, Copyright C 1993, SYBEX Inc 

import math

X = 1.0E-4 / 0.3
for I in range(1, 11):
    Y = math.log(X)
    print ' X =', X, ', Exp(Ln) =', math.exp(Y)
    X = 0.5 * X
