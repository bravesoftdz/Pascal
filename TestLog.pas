PROGRAM Tlog;
 { test ln and exp }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt; { Crt for non-windows version}

VAR
  I: Integer;
  X, Y: Real;

BEGIN
  X := 1.0E-4 / 0.3;
  FOR I := 1 TO 10 DO
    BEGIN
      Y := Ln(X);
      WriteLn(' X =', X,', Exp(Ln) =', Exp(Y));
      X := 0.5 * X
    END;
  Writeln; Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed; 
END.