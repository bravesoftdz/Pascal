PROGRAM Test;
 { test range of floating-point numbers }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES WinCrt; { Crt for non-windows version}

VAR
  I: Integer;
  X: Real;

BEGIN
  WriteLn;
  X := 1.0E-4 / 3.0;
  FOR I := 1 TO 18 DO
    BEGIN
      Write( I:5, X);
      X := 0.1 * X;
      WriteLn('    ', X);
      X := 0.1 * X
    END;
  Writeln;
  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.