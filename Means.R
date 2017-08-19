# http://infohost.nmt.edu/~es421/pascal/list22.pas
# PROGRAM Means
# Find mean and standard deviation
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

Max <- 80
X <- rep(NA, Max) # unnecessary?

# include MeanStd (Listing 2.1)
# but write as 2 separate functions:  myMean and myStd

myMean <- function(X, N) {
  SumX <- 0
  for(I in 1:N) {
    SumX <- SumX + X[I]
  }
  Mean <- SumX/N
  Mean
} # end myMean

myStd <- function(X, N) {
  SumX <- 0
  SumSq <- 0
  for(I in 1:N) {
    SumX <- SumX + X[I]
    SumSq <- SumSq + X[I]^2
  }
  StdDev <- sqrt((SumSq - SumX^2/N)/(N - 1))
  StdDev
} # end myStd

# main program

cat(' Calculation of mean and standard deviation\n')
repeat {
  N <- as.numeric(readline(" How many points (must be <= Max)? "))
  if(N <= Max) break
}
X <- scan(what=double(0), nlines = N)
Mean <- myMean(X, N)
Std <- myStd(X, N)
cat(' For ', N, ' points, mean =', Mean, ', Sigma =', Std, "\n")

# without "for" loop

myMean2 <- function(X, N) {
  SumX <- sum(X)
  Mean <- SumX/N
  Mean
} # end myMean2

myStd2 <- function(X, N) {
  SumX <- sum(X)
  SumSq <- sum(X^2)
  StdDev <- sqrt((SumSq - SumX^2/N)/(N - 1))
  StdDev
} # end myStd2

Mean <- myMean2(X, N)
Std <- myStd2(X, N)
cat(' For ', N, ' points, mean =', Mean, ', Sigma =', Std, "\n")

# without passing N to functions

myMean3 <- function(X) {
  N <- length(X)
  SumX <- sum(X)
  Mean <- SumX/N
  Mean
} # end myMean3

myStd3 <- function(X) {
  N <- length(X)
  SumX <- sum(X)
  SumSq <- sum(X^2)
  StdDev <- sqrt((SumSq - SumX^2/N)/(N - 1))
  StdDev
} # end myStd3

Mean <- myMean3(X)
Std <- myStd3(X)
cat(' For ', N, ' points, mean =', Mean, ', Sigma =', Std, "\n")

# use R functions "mean" and "sd"

Mean <- mean(X)
Std <- sd(X)
cat(' For ', N, ' points, mean =', Mean, ', Sigma =', Std, "\n")
