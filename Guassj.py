# http://infohost.nmt.edu/~es421/pascal/gaussj.htm
# Gauss Jordan matrix inversion and solution
# Adapted from McCormick
# From Borland Pascal Programs for Scientists and Engineers
# by Alan R. Miller, Copyright C 1993, SYBEX Inc

# B(N,N) coefficient matrix, becomes inverse
# Y(N)   original constant vector
# W(N,M) constant vector(s) become solution vector
# Determ is the determinant
# Error = 1 if singular
# Index(N,3)
# Nv is number of constant vectors

PROCEDURE Swap(VAR A, B: FltPt);
VAR
  Hold: FltPt;
BEGIN  { Swap }
  Hold := A;
  A := B;
  B := Hold
END; { procedure Swap }

def Gaussj(B, Y, N):

    #VAR
    #      W: ARRAY[1..Maxc, 1..Maxc] OF FltPt;
    #  Index: ARRAY[1..Maxc, 1..3] OF Integer;
    #  I, J, K, L, Nv, Irow, Icol, N, L1   : Integer;
    #  Determ, Pivot, T, Big: FltPt;

    Error = False
    Nv = 1 # single constant vector
    #N = Ncol

    for I in range(N):
        W[I][1] = Y[I] # copy constant vector
        Index[I][3] = 0
  
    Determ = 1.0
    
    FOR I in range(N):
        # search for largest element
        Big = 0.0
        FOR J in range(N):
            IF Index[J, 3] != 1:
                FOR K in range(N):
                    IF Index[K, 3] > 1:
                        WriteLn(' ERROR: matrix singular')
                        Error = True
                        Exit  # procedure Gaussj
                    IF Index[K, 3] < 1:
                        IF abs(B[J, K]) > Big:
                            Irow = J
                            Icol = K
                            Big = abs(B[J, K])
        Index[Icol, 3] = Index[Icol, 3] + 1
        Index[I, 1] = Irow
        Index[I, 2] = Icol

        # interchange rows to put pivot on diagonal
        IF Irow != Icol:
            Determ = - Determ
            FOR L in range(N):
                Swap(B[Irow, L], B[Icol, L])
            IF Nv > 0:
                FOR L in range(Nv):
                    Swap(W[Irow, L], W[Icol, L])

        # divide Pivot row by Pivot column
        Pivot = B[Icol, Icol]
        Determ = Determ*Pivot
        B[Icol, Icol] = 1.0
        FOR L in range(N):
            B[Icol, L] = B[Icol, L] / Pivot
        IF Nv > 0:
            FOR L in range(Nv):
                W[Icol, L] = W[Icol, L] / Pivot

        # reduce nonpivot rows
        FOR L1 in range(N):
            IF L1 <> Icol:
                T = B[L1, Icol]
                B[L1, Icol] = 0.0
                FOR L in range(N):
                    B[L1, L] = B[L1, L] - B[Icol, L]*T
                IF Nv > 0:
                    FOR in range(Nv):
                        W[L1, L] = W[L1, L] - W[Icol, L]*T
  
    # interchange columns
    FOR I in range(N):
        L = N - I + 1
        IF Index[L, 1] != Index[L, 2]:
            Irow = Index[L, 1]
            Icol = Index[L, 2]
            FOR K in range(N):
                Swap(B[K, Irow], B[K, Icol])

    FOR K in range(N):
        IF Index[K, 3] != 1:
            WriteLn(' ERROR: matrix singular')
            Error = True
            Exit # procedure Gaussj
      
    FOR I in range(N):
        Coef[I] = W[I, 1]