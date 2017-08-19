PROGRAM Rantst;
 { test Gaussian random-number generator Randg }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt;  { Crt for non-windows version}

TYPE
  Ary = ARRAY[1..100] OF Real;

VAR
  X: Ary;
  N, I, J: Integer;
  Aver, Std: Real;

{$I MEANSTD}  { Listing 2.1 }
{$I RANDG}    { Listing 2.4}

BEGIN   { Main program }
  N := 50;
  WriteLn;
  WriteLn( '    mean     std dev');
  WriteLn( '    (10)      (0.5)' );
  WriteLn( '   ====================');
  FOR J := 1 TO 12 DO
    BEGIN
      FOR I := 1 TO N DO
        X[I] :=  Randg(10, 0.5);
      MeanStd( X, N, Aver, Std);
      WriteLn( Aver:10:4, Std:10:4)
    END   { J loop };
  Writeln;
  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
END.