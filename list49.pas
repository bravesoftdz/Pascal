PROGRAM Solvec;
  { simultaneous solution for complex coefficients }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt; { Crt for non-windows version}

CONST
  Maxr = 8;
  Maxc = 8;

TYPE
  FltPt = Real;
  Ary   = ARRAY[1..Maxr] OF FltPt;
  Arys  = ARRAY[1..Maxc] OF FltPt;
  Ary2s = ARRAY[1..Maxr, 1..Maxc] OF FltPt;
  Aryc2 = ARRAY[1..Maxr, 1..Maxc, 1..2] OF FltPt;
  Aryc  = ARRAY[1..Maxr, 1..2] OF FltPt;

VAR
     Y, Coef: Arys;
        A, B: Ary2s;
  N, M, I, J: Integer;
       Error: Boolean;

PROCEDURE Get_Data(VAR A: Ary2s;
                   VAR Y: Arys;
                VAR N, M: Integer);
{ Get complex values for N and arrays A, Y }

VAR
  C: Aryc2;
  V: Aryc;
  I, J, K, L: Integer;

PROCEDURE Show;
  { print original data }

VAR
  I, J, K: Integer;

BEGIN { show }
  WriteLn;
  FOR I:= 1 TO N  DO
    BEGIN
      FOR J:= 1 TO M DO
        FOR K := 1 TO 2 DO
          Write(C[I,J,K]:7:4, '  ');
      WriteLn(' : ', V[I,1]:7:4,' : ',V[I,2]:7:4)
    END;
  N := 2 * N;   M := N;
  WriteLn;
  FOR I:= 1 TO N  DO
    BEGIN
      FOR J:= 1 TO M DO
        Write(A[I,J]:7:4, '  ');
      WriteLn(' : ', Y[I]:9:5)
    END;
  WriteLn
END; { show }

BEGIN { procedure Get_Data }
  WriteLn;
  REPEAT
    Write(' How many equations? ');
    ReadLn(N);
    M := N
  UNTIL N < Maxr;
  IF N > 1 THEN
    BEGIN
      FOR I := 1 TO N DO
        BEGIN
          WriteLn('Equation', I:3);
          K := 0;
          L := 2 * I - 1;
          FOR J := 1 TO N DO
            BEGIN
              K := K + 1;
              Write(' Real ', J:3, ': ');
              Read(C[I,J, 1]); { real part }
              A[L,K] := C[I,J, 1];
              A[L+1,K+1] := C[I,J, 1];
              K := K + 1;
              Write(' Imag ', J:3, ': ');
              Read(C[I,J, 2]); {imaginary part}
              A[L,K] := -C[I,J, 2];
              A[L+1,K-1] := C[I,J, 2]
            END; { J loop }
          Write(' Real CONST: ');
          Read(V[I,1]); { real constant }
          Y[L] := V[I,1];
          Write(' Imag CONST: ');
          ReadLn(V[I,2]); { imaginary constant }
          Y[L+1] := V[I,2]
        END; { I loop }
      Show { original data }
    END  { if N>1 }
END; { procedure Get_Data }

{$I ATAN}   {Listing 1.3}

PROCEDURE Write_Data;
{ print out the answers }

VAR
    I, J: Integer;
  Re, Im: FltPt;

FUNCTION Mag(X, Y: FltPt): FltPt;
 { polar magnitude }
BEGIN
  Mag := Sqrt(Sqr(X) + Sqr(Y))
END; { function Mag }

BEGIN
  WriteLn
    ('     Real     Imaginary   Magnitude   Angle');
  FOR I := 1 TO M DIV 2 DO
    BEGIN
      J := 2*I -1;
      Re := Coef[J];
      Im := Coef[J+1];
      WriteLn(Re:11:5, Im:11:5,
        Mag(Re, Im):11:5,  Atan(Re, Im):11:5)
    END; { FOR }
  WriteLn
END; { Write_Data }

{$I GAUSSJ} {Listing 4.4}

BEGIN  { main program }
  WriteLn;
  WriteLn
    (' Simultaneous solution with complex coefficients');
  WriteLn(' By Gauss-Jordan elimination');
  REPEAT
    Get_Data(A, Y, N, M);
    IF N > 1 THEN
      BEGIN
        FOR I := 1 TO N DO
          FOR J := 1 TO N DO
            B[I,J] := A[I,J]; { Setup work array }
        Gaussj(B, Y, Coef, N, Error);
        IF NOT Error THEN Write_Data
      END
  UNTIL N < 2;
  Writeln; Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.
