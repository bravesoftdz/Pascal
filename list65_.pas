PROCEDURE { quick } Sort
        (VAR X: Ary;
             N: Integer);
 { a recursive sorting routine }
 { Adapted from The design of Well-
     Structured and Correct Programs,
     S. Alagic, Springer-Verlag, 1978 }

PROCEDURE Qsort
        (VAR X: Ary;
          M, N: Integer);
VAR
  I, J: Integer;

PROCEDURE Partit
          (VAR    A: Ary;
           VAR I, J: Integer;
        Left, Right: Integer);
VAR
  Pivot: Sort_Var;

{$I swap.pas} {Listing 6.2}

BEGIN
  Pivot := A[(Left + Right) DIV 2];
  I := Left;
  J := Right;
  WHILE I <= J DO
    BEGIN
      WHILE A[I] < Pivot DO
        I := I + 1;
      WHILE Pivot < A[J] DO
        J := J - 1;
      IF I <= J THEN
        BEGIN
          Swap(A[I], A[J]);
          I := I + 1;
          J := J - 1
        END
    END { WHILE }
END; { Partit }

BEGIN { Qsort }
  IF M < N THEN
    BEGIN
      Partit(X, I, J, M, N); { divide in two }
      Qsort(X, M, J); { Sort left part  }
      Qsort(X, I, N)  { Sort right part }
    END
END; { Qsort }

BEGIN { Sort }
  Qsort(X, 1, N)
END; { Sort }