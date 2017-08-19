PROGRAM Simp1;
  { integration by Simpson's method }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt; { Crt for non-windows version }

CONST
  Tol = 1.0E-5;

VAR
  Sum, Upper, Lower: Real;

FUNCTION Fx(X: Real): Real;
  { find f(X) = 1 / X }
  { watch out for X = 0 }

BEGIN
  Fx := 1.0 / X
END;  { function Fx }

PROCEDURE Simps(Lower, Upper, Tol: Real;
                          VAR Sum: Real);
{ function is Fx, limits are Lower and Upper }
{ with number of regions equal to Pieces }
{ partition is Delta_X, answer is Sum }

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
  WriteLn(Pieces:5, Sum:9:5);
  REPEAT
    Pieces := Pieces * 2;
    Sum1 := Sum;
    Delta_X := (Upper - Lower) / Pieces;
    Even_Sum := Even_Sum + Odd_Sum;
    Odd_Sum := 0.0;
    FOR I:= 1 TO Pieces DIV 2 DO
      BEGIN
        X := Lower + Delta_X * (2.0*I - 1.0);
        Odd_Sum := Odd_Sum + Fx(X)
      END;
    Sum := (End_Sum + 4.0*Odd_Sum + 2.0*Even_Sum) * Delta_X / 3.0;
    WriteLn(Pieces:5, Sum:9:5)
  UNTIL Abs(Sum - Sum1) <= Abs(Tol * Sum)
END; { Simps }

BEGIN { main program }
  Lower := 1.0; Upper := 9.0;
  WriteLn;
  Simps(Lower, Upper, Tol, Sum);
  WriteLn; WriteLn(' area = ', Sum:9:5);
  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
END.