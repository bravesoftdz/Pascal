PROGRAM Solvgj;
 { solution by Gauss-Jordan elimination }
 { there may be more equations than unknowns }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt; { Crt for non-windows version}

CONST
  Maxr = 8;  Maxc = 8;

TYPE
  FltPt = Real;
  Ary   = ARRAY[1..Maxr] OF FltPt;
  Arys  = ARRAY[1..Maxc] OF FltPt;
  Ary2s = ARRAY[1..Maxr, 1..Maxc] OF FltPt;
  Ary2  = Ary2s; { for Square }

VAR
           Y: Ary;
    Coef, Yy: Arys;
        A, B: Ary2s;
  N, M, I, J: Integer;
       Error: Boolean;

PROCEDURE Get_Data(VAR A: Ary2s;
           VAR Y: Ary;
                VAR N, M: Integer);
{ Get values for N and arrays A, Y }

VAR
  I, J: Integer;

BEGIN
  WriteLn;
  REPEAT
    Write(' How many unknowns? ');
    ReadLn(M)
  UNTIL M < Maxc;
  IF M > 1 THEN
    BEGIN
      REPEAT
        Write(' How many equations? ');
        ReadLn(N)
      UNTIL N >= M;
      FOR I := 1 TO N DO
        BEGIN
          WriteLn(' Equation', I:3);
          FOR J := 1 TO M DO
            BEGIN
              Write(J:3, ': ');
              Read(A[I,J])
            END;
          Write(' C: ');
          ReadLn(Y[I])   { clear line }
        END; { I loop }
      WriteLn;
      FOR I:= 1 TO N  DO
        BEGIN
          FOR J:= 1 TO M DO
        Write(A[I,J]:7:4, '  ');
          WriteLn(' : ', Y[I]:7:4)
        END;
      WriteLn
    END  { if N>1 }
END; { procedure Get_Data }

PROCEDURE Write_Data;
   { print out the answers }

VAR
  I: Integer;

BEGIN
  FOR I := 1 TO M DO
    Write(Coef[I]:9:5);
  WriteLn
END; { Write_Data }

{$I SQUARE} { Listing 3.2}
{$I GAUSSJ} { Listing 4.4}

BEGIN  { main program }
  WriteLn;
  WriteLn(' Best fit to simultaneous equations');
  WriteLn(' By Gauss-Jordan');
  REPEAT
    Get_Data(A, Y, N, M);
    IF M > 1 THEN
      BEGIN
        Square(A, Y, B, Yy, N, M);
        Gaussj(B, Yy, Coef, M, Error);
        IF NOT Error THEN Write_Data
      END
  UNTIL M < 2;
  Writeln;  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.
