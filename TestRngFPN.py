# http://infohost.nmt.edu/~es421/pascal/list11.pas
# PROGRAM Test
# test range of floating-point numbers 
# From Borland Pascal Programs for Scientists and Engineers 
# by Alan R. Miller, Copyright C 1993, SYBEX Inc 

X = 1.0E-4 / 3.0;
for I in  range(1, 19):
    print I, X,
    X = 0.1 * X
    print X
    X = 0.1 * X
