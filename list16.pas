PROGRAM Tasin;
 { test ArcSin and ArcTan }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt; { Crt for non-windows version}

VAR
  X, Y, Z, Pid180: Real;
  I: Integer;

{$I ASIN}  { Listing 1.4}

BEGIN { main program }
  Pid180 := Pi / 180.0;
  WriteLn('    Sine   Arcsine    Sine');
  FOR I:=1 TO 6 DO
    BEGIN
        X := (I-1) * 0.2; Y := ArcSin(X);
        Z := Y * Pid180;
        WriteLn(X:9:4, Y:9:4, Sin(Z):9:4)
    END;
  Writeln; Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.