# http://infohost.nmt.edu/~es421/pascal/list23.pas
# PROGRAM Rantst
# test random-number generator Random
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

N <- 48
X <- rep(NA, N) 

for(J in 1:12) {
  for(I in 1:N) {
    X[I] <- rnorm(1, mean = 0.5, sd = 0.2887)
  }
  Mean <- mean(X)
  Std <- sd(X)
  if(J == 1) {
    cat('    mean     std dev\n')
    cat('    (0.5)    (0.2887)\n')
    cat('   ====================\n')
  }
  cat(sprintf("%10.4f %10.4f", Mean, Std), "\n")
} # end J loop

# without "for" loop for I

for(J in 1:12) {
  X <- rnorm(N, mean = 0.5, sd = 0.2887)
  Mean <- mean(X)
  Std <- sd(X)
  if(J == 1) {
    cat('    mean     std dev\n')
    cat('    (0.5)    (0.2887)\n')
    cat('   ====================\n')
  }
  cat(sprintf("%10.4f %10.4f", Mean, Std), "\n")
} # end J loop

# without "for" loop for J

X <- matrix(rnorm(12*N, mean = 0.5, sd = 0.2887), ncol = N, byrow = TRUE)
Mean <- apply(X, 1, mean)
Std <- apply(X, 1, sd)
data.frame(Mean, Std)

rm(list = ls())