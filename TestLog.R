# http://infohost.nmt.edu/~es421/pascal/list12.pas
# PROGRAM Tlog
# test ln and exp
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

X <- 1.0E-4 / 0.3;
for (I in 1:10) {
  Y <- log(X)
  cat(' X =', X, ', Exp(Ln) =', exp(Y), "\n")
  X <- 0.5 * X
}

# without "for" loop

X <- (0.5^c(0:9))/(3*10^3)
Y <- log(X)
LabelX <- rep(" X =", 10)
LabelY <- rep(", Exp(Ln) =", 10)
data.frame(LabelX, X, LabelY, expY = exp(Y))