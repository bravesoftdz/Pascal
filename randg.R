# http://infohost.nmt.edu/~es421/pascal/randg.htm
# FUNCTION Randg(Mean, Sigma: Real): Real
# produce random numbers with a Gaussian distribution
# Mean and Sigma are supplied by calling program
# Function Random is required
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

randg <- function(Mean, Sigma) {
  Sum <- 0
  for(I in 1:12) {
    Sum <- Sum + runif(1)
  }
  Randg <- (Sum - 6)*Sigma + Mean
}