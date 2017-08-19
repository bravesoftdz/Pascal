PROGRAM Solvgv;
  { simultaneous solution by Gauss-Jordan
    elimination with multiple constant vectors }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt; { Crt for non-windows version}

CONST
  Maxr = 7;
  Maxc = 7;

TYPE
  FltPt = Real;
  Ary2s = ARRAY[1..Maxr, 1..Maxc] OF FltPt;

VAR
     A, Y: Ary2s;
  N, Nvec: Integer;
    Error: Boolean;
   Determ: FltPt;

PROCEDURE Get_Data(VAR A: Ary2s;
                   VAR Y: Ary2s;
             VAR N, Nvec: Integer);
{ Get values for N, Nvec, and arrays A, Y }

VAR
  I, J: Integer;

BEGIN
  WriteLn;
  REPEAT
    Write(' How many equations? ');
    ReadLn(N)
  UNTIL N < Maxr;
  IF N > 1 THEN
    BEGIN
      Write(' How many constant vectors? ');
      ReadLn(Nvec);
      FOR I := 1 TO N DO
        BEGIN
          FOR J := 1 TO N DO
            BEGIN
              Write(J:3, ': ');
              Read(A[I,J])
            END;
          IF Nvec > 0 THEN
            BEGIN
              FOR J := 1 TO Nvec DO
                BEGIN
                  Write(', C: ');
                  Read(Y[I,J])
                END;
             WriteLn;
            END
          ELSE {matrix determinant only}
             WriteLn;
        END; { I loop }
      WriteLn;
      Write('           Matrix');
      IF Nvec > 0 THEN
        Write('          Constants');
      WriteLn;
      FOR I:= 1 TO N  DO
        BEGIN
          FOR J:= 1 TO N DO
            Write(A[I,J]:7:4, '  ');
          FOR J := 1 TO Nvec DO
            Write(' :', Y[I,J]:7:4);
          WriteLn
        END; { I loop }
      WriteLn
    END  { if N>1 }
END; { procedure Get_Data }

PROCEDURE Write_Data;
   { print out the answers }
VAR
  I, J: Integer;

BEGIN
  IF Nvec > 0 THEN
    BEGIN
      WriteLn(' Solution');
      FOR I := 1 TO N DO
        BEGIN
          FOR J := 1 TO Nvec DO
            Write(Y[I,J]:9:5);
          WriteLn
        END
    END { if }
  ELSE
    BEGIN
      WriteLn('     Inverse');
      FOR I := 1 TO N DO
        BEGIN
          FOR J := 1 TO N DO
            Write('  ',A[I,J]:10);
          WriteLn
        END;
      WriteLn;
      Write(' Determinant is ', Determ:12)
    END; { ELSE }
  WriteLn
END; { Write_Data }

PROCEDURE Gaussjv
   (VAR B : Ary2s; { square matrix of coefficients }
    VAR W : Ary2s;  { constant vector matrix }
    VAR Determ: FltPt;  { the determinant }
    Ncol      : Integer;  { order of matrix }
    Nv        : Integer;  { number of constants }
     VAR Error: Boolean); { True of matrix singular }

{      Gauss Jordan matrix inversion and solution
   B(N,N) coefficient matrix, becomes inverse
   W(N,M) constant vector(s) become solution vector
   Determ is determinant
   Error = 1 if singular
   Index(N,3)
   Nv is number of constant vectors }

VAR
  Index: ARRAY[1..Maxc, 1..3] OF Integer;
  I, J, K, L, Irow, Icol, N, L1: Integer;
  Pivot, T, Big: FltPt;

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
  N := Ncol;
  FOR I := 1 TO N DO
      Index[I, 3] := 0;
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
                      Exit  {procedure Gaussj }
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

      { divide pivot row by pivot column }
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
        Exit  {procedure Gaussj }
      END;
END; { procedure Gaussjv }

BEGIN  { main program }
  WriteLn;
  WriteLn(' Simultaneous solution by Gauss-Jordan');
  WriteLn
    (' Multiple constant vectors, or matrix inverse');
  REPEAT
    Get_Data(A, Y, N, Nvec);
    IF N > 1 THEN
      BEGIN
        Gaussjv(A, Y, Determ, N, Nvec, Error);
        IF NOT Error THEN  Write_Data
      END
  UNTIL N < 2;
  DoneWinCrt  { for Windows version only }
END.
