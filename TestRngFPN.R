# http://infohost.nmt.edu/~es421/pascal/list11.pas
# PROGRAM Test
# test range of floating-point numbers 
# From Borland Pascal Programs for Scientists and Engineers 
# by Alan R. Miller, Copyright C 1993, SYBEX Inc 

X <- 1.0E-4 / 3.0
for(I in 1:18) {
  cat(I, X);
  X <- 0.1 * X;
  cat('    ', X, '\n');
  X <- 0.1 * X
}

# without "for" loop

X <- (1/3)/10^(4:39)
matrix(X, ncol = 2, byrow = TRUE)
