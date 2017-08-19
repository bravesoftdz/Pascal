PROGRAM Erfsimp;
  { integration by Simpson's method }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt;  { Crt for non-windows version }

CONST
  Tol = 1.0E-5;

VAR
  Done: Boolean;
  Sum, Upper, Lower, Erf,
  Twopi: Real;

FUNCTION Fx( X: Real): Real;
BEGIN
  Fx := Exp(-X * X)
END;   { Function Fx }

PROCEDURE Simps(Lower, Upper, Tol: Real;
                          VAR Sum: Real);
{ numerical integration by Simpson's method
  function is Fx, limits are Lower and Upper
  with number of regions equal to Pieces.
  Partition is Delta_X, answer is Sum }

VAR
  I, Pieces: Integer;
  X, Delta_X, Even_Sum,
  Odd_Sum, End_Sum, Sum1: Real;

BEGIN
  Pieces := 2;
  Delta_X := (Upper - Lower) / Pieces;
  Odd_Sum := Fx(Lower + Delta_X);
  Even_Sum := 0.0;
  End_Sum := Fx(Lower) + Fx(Upper);
  Sum := (End_Sum + 4.0*Odd_Sum) * Delta_X / 3.0;
  REPEAT
    Pieces := Pieces * 2;
    Sum1 := Sum;
    Delta_X := (Upper - Lower) / Pieces;
    Even_Sum := Even_Sum + Odd_Sum;
    Odd_Sum := 0.0;
    FOR I:= 1 TO Pieces DIV 2 DO
      BEGIN
        X := Lower + Delta_X * (2.0*I -1.0);
        Odd_Sum := Odd_Sum + Fx(X)
      END;
    Sum := (End_Sum + 4.0*Odd_Sum
           + 2.0*Even_Sum) * Delta_X / 3.0
  UNTIL Abs(Sum1 - Sum) <= Abs(Tol * Sum1)
END; { Simps }

BEGIN { main program }
  Done := False;
  Twopi := 2.0/Sqrt(Pi);
  Lower := 0.0;
  REPEAT
    WriteLn; Write(' Erf? ');
    ReadLn(Upper);
    IF Upper < 0.0 THEN 
      Done := True
    ELSE IF Upper = 0.0 THEN
      WriteLn(' Erf of 0.0 is 0.0')
    ELSE   { Upper > 0 }
      BEGIN
        Simps(Lower, Upper, Tol, Sum);
        Erf := Twopi * Sum;
        WriteLn(' Erf of ', Upper:7:2,
          ', is ', Erf:8:4)
      END
  UNTIL Done;
  DoneWinCrt { for Windows version only }
END.