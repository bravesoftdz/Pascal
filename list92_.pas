PROGRAM Trap2;
  { integration by the trapezoidal method }
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
END;

PROCEDURE Trapez(Lower, Upper, Tol: Real;
                           VAR Sum: Real);
{ limits are Lower and Upper }
{ with number of regions equal to Pieces }
{ partition width is Delta_X, answer is Sum }

VAR
  Pieces, I: Integer;
  X, Delta_X, End_Sum, Mid_Sum, Sum1: Real;

BEGIN
  Pieces := 1;
  Delta_X := (Upper - Lower) / Pieces;
  End_Sum := Fx(Lower) + Fx(Upper);
  Sum := End_Sum * Delta_X / 2.0;
  WriteLn('    1', Sum:9:5);
  Mid_Sum := 0.0;
  REPEAT
    Pieces := Pieces * 2;
    Sum1 := Sum;
    Delta_X := (Upper - Lower) / Pieces;
    FOR I := 1 TO Pieces DIV 2 DO
      BEGIN
        X := Lower + Delta_X *(2.0*I - 1.0);
        Mid_Sum := Mid_Sum + Fx(X)
      END;
    Sum := (End_Sum + 2.0*Mid_Sum) * Delta_X * 0.5;
    WriteLn(Pieces:5, Sum:9:5)
  UNTIL Abs(Sum - Sum1) <= Abs(Tol * Sum)
END; { Trapez }

BEGIN { main program }
  Lower := 1.0;
  Upper := 9.0;
  WriteLn;
  Trapez(Lower, Upper, Tol, Sum);
  WriteLn;
  WriteLn(' area = ', Sum:9:5);
  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
END.