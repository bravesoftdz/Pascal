# http://infohost.nmt.edu/~es421/pascal/randg.htm
# FUNCTION Randg(Mean, Sigma: Real): Real
# produce random numbers with a Gaussian distribution
# Mean and Sigma are supplied by calling program
# Function Random is required
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

import random

def randg(Mean, Sigma):
    Sum = 0
    for I in range(12):
        Sum = Sum + random.random()
    Randg = (Sum - 6)*Sigma + Mean
    return Randg