# http://infohost.nmt.edu/~es421/pascal/list33.htm
# PROGRAM Determ
# the determinant of a 3-by-3 matrix
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

getData <- function() { # get values for array A
  N <- 3
  A <- scan(what=double(0), nlines = N*N)
  A <- matrix(A, nrow = N, ncol = N, byrow = TRUE)
  for(I in 1:N) {
    for(J in 1:N) cat(sprintf("%7.4f", A[I, J]), "  ")
    cat("\n")
  }
  A
} # end function getData

deter <- function(A) { # calculate the determinant of a 3-by-3 matrix
  Sum <-       A[1, 1]*(A[2, 2]*A[3, 3] - A[3, 2]*A[2, 3])
  Sum <- Sum - A[1, 2]*(A[2, 1]*A[3, 3] - A[3, 1]*A[2, 3])
  Sum <- Sum + A[1, 3]*(A[2, 1]*A[3, 2] - A[3, 1]*A[2, 2])
  Sum
}

# main program
A <- getData()
D <- deter(A)
cat("The determinant is ", D, "\n")

# use built in R function
D <- det(A)
cat("The determinant is ", D, "\n")