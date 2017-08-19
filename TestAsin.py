# http://infohost.nmt.edu/~es421/pascal/list16.htm
# PROGRAM Tasin
# test ArcSin and ArcTan
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc 

import math

Pid180 = math.pi / 180.0
print '    Sine    Arcsine     Sine'
for I in range(1, 7):
    X = (I - 1) * 0.2
    Y = math.asin(X)/Pid180
    Z = Y * Pid180
    print '%9.4f %9.4f %9.4f' % (X, Y, math.sin(Z))
