PROGRAM Rantst;
 { test random-number generator Random }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES WinCrt; { Crt for non-windows version}

TYPE
  Ary = ARRAY[1..100] OF Real;

VAR
  X: Ary;
  N, I, J: Integer;
  Mean, Std: Real;

{$I MEANSTD}  { Listing 2.1}

BEGIN   { Main program }
  N := 48;
  WriteLn;
  WriteLn( '    mean     std dev');
  WriteLn( '    (0.5)    (0.2887)' );
  WriteLn( '   ====================');
  FOR J := 1 TO 12 DO
    BEGIN
      FOR I := 1 TO N DO
        X[I] := Random;
      MeanStd( X, N, Mean, Std);
      WriteLn( Mean:10:4, Std:10:4)
    END;  { J loop }
  Writeln; Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.