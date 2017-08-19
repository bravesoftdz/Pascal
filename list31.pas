PROGRAM Matr1;
 { matrix multiplication }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt;  { Crt for non-windows version}

CONST
  Rmax = 9; Cmax = 3;

TYPE
  Ary   = ARRAY[1..Rmax] OF Real;
  Arys  = ARRAY[1..Cmax] OF Real;
  Ary2  = ARRAY[1..Rmax, 1..Cmax] OF Real;
  Ary2s = ARRAY[1..Cmax, 1..Cmax] OF Real;

VAR
  Y: Ary;
  G: Arys;
  X: Ary2;
  A: Ary2s;
  Nrow, Ncol: Integer;

PROCEDURE Get_Data(VAR X: Ary2;
                   VAR Y: Ary;
          VAR Nrow, Ncol: Integer);
{ get values for Nrow, Ncol, and arrays X, Y }

VAR
  I, J: Integer;

BEGIN
  Nrow := 5;
  Ncol := 3;
  FOR I := 1 TO Nrow DO
    BEGIN
      X[I,1] := 1;
      FOR J := 2 TO Ncol DO
        X[I,J] := I * X[I,J-1];
      Y[I] := 2 * I
    END
END; { procedure Get_Data }

PROCEDURE Write_data;
 { print out the answers }

VAR
  I, J: Integer;

BEGIN
  WriteLn;
  WriteLn('         X                     Y');
  FOR I := 1 TO Nrow DO
    BEGIN
      FOR J := 1 TO Ncol DO
        Write( X[I,J]:7:1, '  ');
      WriteLn( ' : ', Y[I]:7:1)
    END;
  WriteLn('         A                     G');
  FOR I := 1 TO Ncol DO
    BEGIN
      FOR J := 1 TO Ncol DO
        Write( A[I,J]:7:1, '  ');
      WriteLn( ' : ', G[I]:7:1)
    END
END; { Write_data }

{$I SQUARE}  { Listing 3.2}

BEGIN  { main program }
  Get_Data (X, Y, Nrow, Ncol);
  Square(X, Y, A, G, Nrow, Ncol);
  Write_data; Writeln;
  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.
