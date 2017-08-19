# http://infohost.nmt.edu/~es421/pascal/list16.htm
# PROGRAM Tasin
# test ArcSin and ArcTan
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

Pid180 <- pi / 180.0
for(I in 1:6) {
  X <- (I - 1) * 0.2
  Y <- asin(X)/Pid180
  Z <- Y * Pid180
  if(I == 1) cat('    Sine    Arcsine     Sine\n')
  cat(sprintf("%9.4f %9.4f %9.4f", X, Y, sin(Z)), "\n")
}

# without "for" loop

I <- c(1:6)
X <- (I - 1) * 0.2
Y <- asin(X)/Pid180
Z <- Y * Pid180
data.frame(Sine1 = X, Arcsine = Y, Sine2 = sin(Z))