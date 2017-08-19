# http://infohost.nmt.edu/~es421/pascal/list31.pas
# PROGRAM Matr1
# matrix multiplication
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

source("square.R") # Listing 3.2

getDataX <- function(Nrow, Ncol) {  # get values array X
  X <- matrix(rep(0, Nrow*Ncol), nrow = Nrow, ncol = Ncol, byrow = TRUE)
  for(I in 1:Nrow) {
    X[I, 1] <- 1
    for(J in 2:Ncol) X[I, J] <- I*X[I, J - 1]
  }
  X
}

getDataY <- function(Nrow) {  # get values for array Y
  Y <- rep(0, Nrow)
  for(I in 1:Nrow) Y[I] <- 2*I
  Y
}

writeData <- function(X, Y, A, G, Nrow, Ncol) {  # print out the answers
  cat("            X              Y\n")
  for(I in 1:Nrow) {
    for(J in 1:Ncol) cat(sprintf("%7.1f", X[I, J]))
    cat(sprintf(" : %7.1f", Y[I]), "\n")
  }
  cat("            A              G\n")
  for(I in 1:Ncol) {
    for(J in 1:Ncol) cat(sprintf("%7.1f",  A[I,J]))
    cat(sprintf(" : %7.1f", G[I]), "\n")
  }
}

# main program

Nrow <- 5
Ncol <- 3

X <- getDataX(Nrow, Ncol)
Y <- getDataY(Nrow)
A <- MatSquare(X, Nrow, Ncol)
G <- MatMult(X, Y, Nrow, Ncol)
writeData(X, Y, A, G, Nrow, Ncol)

# use built in R functions

A <- t(X) %*% X
G <- t(X) %*% Y

data.frame(X, Y)
data.frame(A, G)