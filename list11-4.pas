PROGRAM Tstgam;
  { test the Gamma function }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt; { Crt for non-windows version }

VAR
  X: Real;

FUNCTION Gamma(X: Real): Real;
VAR
  I, J: Integer;
  Y, Gam: Real;

BEGIN    { Gamma function }
  IF X >= 0.0 THEN
    BEGIN
      Y := X + 2.0;
      Gam := Sqrt(2 * Pi/Y)
        * Exp(Y*Ln(Y) + (1 - 1/(30*Y*Y))/(12*Y)-Y);
      Gamma := Gam / (X * (X+1))
    END
  ELSE  { X < 0 }
    BEGIN
      J := 0;  Y := X;
      REPEAT { increment argument until positive }
        J := J + 1;
        Y := Y + 1.0
      UNTIL Y > 0.0;
      Gam := Gamma(Y); { recursive call }
      FOR I := 0 TO J-1 DO
        Gam := Gam / (X + I);
      Gamma := Gam
    END   { if }
END; { Gamma function }

BEGIN  { main program }
  WriteLn( ' The Gamma Function');
  REPEAT
    REPEAT
      Write(' X: ');
      ReadLn( X)
    UNTIL X <> 0.0;
    WriteLn(' Gamma is ', Gamma(X):9:4)
  UNTIL X < -22.0;
  DoneWinCrt  { for Windows version only }
END.