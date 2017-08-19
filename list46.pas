PROGRAM Hilbert;
 { solution by Gauss-Jordan elimination }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
 { N x N inverse Hilbert matrix }
 { solution is 1 1 1 1 1 }
USES WinCrt;  { Crt for non-windows version}

CONST
  Maxr = 11;  Maxc = 11;

TYPE
  FltPt = Real;  { or Double }
  Arys  = ARRAY[1..Maxc] OF FltPt;
  Ary2s = ARRAY[1..Maxr, 1..Maxc] OF FltPt;

VAR
     Y, Coef: Arys;
        A, B: Ary2s;
  N, M, I, J: Integer;
       Error: Boolean;

PROCEDURE Get_Data(VAR A: Ary2s;
                   VAR Y: Arys;
                VAR N, M: Integer);
   { Setup N-by-N hilbert matrix }
VAR
  I, J: Integer;

BEGIN
  FOR I := 1 TO N-1 DO
    BEGIN
      A[N,I] := 1.0/(N + I - 1);
      A[I,N] := A[N,I]
    END;
  A[N,N] := 1.0/(2*N -1);
  FOR I := 1 TO N DO
    BEGIN
      Y[I] := 0.0;
      FOR J := 1 TO N DO
        Y[I] := Y[I] + A[I,J]
    END;
  WriteLn;
  IF N < 7 THEN
    BEGIN
      FOR I:= 1 TO N  DO
        BEGIN
          FOR J:= 1 TO M DO Write(A[I,J]:7:5, '  ');
          WriteLn(' : ', Y[I]:7:5)
        END;
      WriteLn
    END  { if N<7 }
END; { procedure Get_Data }

PROCEDURE Write_Data;
   { print out the answers }
VAR
  I: Integer;

BEGIN
  WriteLn(' Solution for', M:3, ' equations');
  IF M > 6 THEN
    BEGIN
       FOR I := 1 TO 6 DO Write(Coef[I]:11:7);
       Writeln;
       FOR I := 7 TO M DO Write(Coef[I]:11:7)
    END
  ELSE
    FOR I := 1 TO M DO Write(Coef[I]:11:7);
  WriteLn;
END; { Write_Data }

{$I GAUSSJ} {Listing 4.4}

BEGIN  { main program }
  A[1,1] := 1.0;
  N := 2; M := N;
  REPEAT
    Get_Data(A, Y, N, M);
    FOR I := 1 TO N DO
      FOR J := 1 TO N DO
        B[I,J] := A[I,J]; { Setup work array }
    Gaussj(B, Y, Coef, N, Error);
    IF NOT Error THEN Write_Data;
    N := N+1;  M := N
  UNTIL N > Maxr;
  Writeln; Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.
