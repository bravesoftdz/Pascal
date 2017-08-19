PROGRAM Means;
 { Find mean and standard deviation }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt; { Crt for non-windows version}

CONST
  Max = 80;

TYPE
  Ary = ARRAY[1..Max] OF Real;

VAR
  X: Ary;
  I, N: Integer;
  Mean, Std: Real;

{$I MEANSTD}  { Listing 2.1}

BEGIN { main program }
  WriteLn;
  WriteLn(' Calculation of mean and standard deviation');
  REPEAT
    Write(' How many points? '); ReadLn(N)
  UNTIL N <= Max;
  FOR I:=1 TO N DO
    BEGIN
      Write( I:3,': '); ReadLn(X[I])
    END;
  MeanStd( X, N, Mean, Std);
  WriteLn;
  WriteLn(' For ', N:3, ' points, mean=', Mean:8:4,
          ', sigma=', Std:8:4);
  Writeln; Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.