# http://infohost.nmt.edu/~es421/pascal/list25.pas
# PROGRAM Rantst
# test Gaussian random-number generator Randg
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

source("randg.R") # Listing 2.4

N <- 50

for (J in 1:12) {
  if(J == 1) {
    cat('    mean     std dev\n')
    cat('    (10)      (0.5)\n')
    cat('   ====================\n')
  }
  for(I in 1:N) {
    X[I] <-  randg(10, 0.5);
  }
  Mean <- mean(X)
  Std <- sd(X)
  cat(sprintf("%10.4f %10.4f", Mean, Std), "\n")
} # J loop

