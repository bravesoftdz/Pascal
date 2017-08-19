PROGRAM Cfit1;
  { linear least-squares fit }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt;  { for Windows version only }

CONST
  Max = 20;

TYPE
  Ary = ARRAY[1..Max] OF Real;

VAR
  X, Y, Y_Calc: Ary;
  N: Integer;
  Done: Boolean;
  A, B: Real;

PROCEDURE Get_Data(VAR X, Y: Ary;
                      VAR N: Integer);
{ Get values for N and arrays X, Y }
{ Y is randomly scattered about a straight line }

CONST
  A = 2.0;
  B = 5.0;

VAR
    I, J: Integer;
  Factor: Real;

BEGIN
  Write('Factor? ');
  ReadLn(Factor);
  IF Factor < 0.0 THEN 
    Done := True
  ELSE
    BEGIN
      REPEAT
        Write('How many points? ');
        ReadLn(N)
      UNTIL (N > 2) AND (N <=  Max);
      FOR I := 1 TO N DO
        BEGIN
          J := N +1 -I;
          X[I] := J;
          Y[I] :=
            (A + B*J)*(1.0 +(2.0*Random-1.0)*Factor)
        END   { FOR loop }
    END  { IF }
END; { procedure Get_Data }

PROCEDURE Write_Data;
  { print out the answers }
VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn('  I      X       Y');
  FOR I := 1 TO N DO
    WriteLn(I:3, X[I]:8:1, Y[I]:9:2);
  WriteLn
END; { Write_Data }

BEGIN  { main program }
  Done := False;
  REPEAT
    Get_Data(X, Y, N);
    IF NOT Done THEN
      BEGIN
        Write_Data;
        { more lines to be added here }
      END
  UNTIL Done;
  Writeln; Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.