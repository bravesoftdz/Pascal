PROCEDURE Gaussj
      (VAR B: Ary2s;  { square matrix of coefficients }
           Y: Arys;  { constant vector }
    VAR Coef: Arys;  { solution vector }
        Ncol: Integer;  { order of matrix }
   VAR Error: Boolean); { True if matrix singular }

{  Gauss Jordan matrix inversion and solution
   Adapted from McCormick
    B(N,N) coefficient matrix, becomes inverse
    Y(N)   original constant vector
    W(N,M) constant vector(s) become solution vector
    Determ is the determinant
    Error = 1 if singular
    Index(N,3)
    Nv is number of constant vectors }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

VAR
      W: ARRAY[1..Maxc, 1..Maxc] OF FltPt;
  Index: ARRAY[1..Maxc, 1..3] OF Integer;
  I, J, K, L, Nv, Irow, Icol, N, L1   : Integer;
  Determ, Pivot, T, Big: FltPt;

PROCEDURE Swap(VAR A, B: FltPt);

VAR
  Hold: FltPt;

BEGIN  { Swap }
  Hold := A;
  A := B;
  B := Hold
END; { procedure Swap }

BEGIN     { Gauss-Jordan main program }
  Error := False;
  Nv := 1; { single constant vector }
  N := Ncol;
  FOR I := 1 TO N DO
    BEGIN
      W[I, 1] := Y[I]; { copy constant vector }
      Index[I, 3] := 0
    END;
  Determ := 1.0;
  FOR I := 1 TO N DO
    BEGIN
      { search for largest element }
      Big := 0.0;
      FOR J := 1 TO N DO
        BEGIN
          IF Index[J, 3] <> 1 THEN
            BEGIN
              FOR K := 1 TO N DO
                BEGIN
                  IF Index[K, 3] > 1 THEN
                    BEGIN
                      WriteLn(' ERROR: matrix singular');
                      Error := True;
                      Exit  { procedure Gaussj }
                    END;
                  IF Index[K, 3] < 1 THEN
                    IF Abs(B[J, K]) > Big THEN
                      BEGIN
                        Irow := J;
                        Icol := K;
                        Big := Abs(B[J, K])
                      END
                END { K loop }
            END
        END; { J loop }
      Index[Icol, 3] := Index[Icol, 3] + 1;
      Index[I, 1] := Irow;
      Index[I, 2] := Icol;

  { interchange rows to put pivot on diagonal }
  IF Irow <> Icol THEN
    BEGIN
      Determ := - Determ;
      FOR L := 1 TO N DO
        Swap(B[Irow, L], B[Icol, L]);
      IF Nv > 0 THEN
        FOR L := 1 TO Nv DO
          Swap(W[Irow, L], W[Icol, L])
    END; { if Irow <> Icol }

      { divide Pivot row by Pivot column }
      Pivot := B[Icol, Icol];
      Determ := Determ * Pivot;
      B[Icol, Icol] := 1.0;
      FOR L := 1 TO N DO
        B[Icol, L] := B[Icol, L] / Pivot;
      IF Nv > 0 THEN
        FOR L := 1 TO Nv DO
          W[Icol, L] := W[Icol, L] / Pivot;
      {  reduce nonpivot rows }
      FOR L1 := 1 TO N DO
        BEGIN
          IF L1 <> Icol THEN
            BEGIN
              T := B[L1, Icol];
              B[L1, Icol] := 0.0;
              FOR L := 1 TO N DO
                B[L1, L] := B[L1, L] - B[Icol, L] * T;
              IF Nv > 0 THEN
                FOR L := 1 TO Nv DO
                  W[L1, L] := W[L1, L] - W[Icol, L] * T;
            END   { IF L1 <> Icol }
        END
    END; { I loop }
    { interchange columns }
  FOR I := 1 TO N DO
    BEGIN
      L := N - I + 1;
      IF Index[L, 1] <> Index[L, 2] THEN
        BEGIN
          Irow := Index[L, 1];
          Icol := Index[L, 2];
          FOR K := 1 TO N DO
            Swap(B[K, Irow], B[K, Icol])
        END { if Index }
    END; { I loop }
  FOR K := 1 TO N DO
    IF Index[K, 3] <> 1 THEN
      BEGIN
        WriteLn(' ERROR: matrix singular');
        Error := True;
        Exit  { procedure Gaussj }
      END;
  FOR I := 1 TO N DO
    Coef[I] := W[I, 1];
END; { procedure Gaussj }
