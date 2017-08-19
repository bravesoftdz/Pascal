# http://infohost.nmt.edu/~es421/pascal/square.htm
# PROCEDURE Square
# matrix multiplication routine
# A = transpose X times X
# G = Y times X
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

MatSquare <- function(X, Nrow, Ncol) {
  A <- matrix(rep(0, Nrow*Ncol), nrow = Nrow, ncol = Ncol, byrow = TRUE)
  for(K in 1:Ncol) {
    for(L in 1:K) {
      for(I in 1:Nrow) {
        A[K, L] <- A[K, L] + X[I, L]*X[I, K]
        if(K != L) A[L, K] <- A[K, L]
      }
    }
  }
  A
}

MatMult <- function(X, Y, Nrow, Ncol) {
  G <- rep(0, Ncol)
  for(K in 1:Ncol)
    for(I in 1:Nrow)
      G[K] <- G[K] + Y[I]*X[I, K]
  G
}