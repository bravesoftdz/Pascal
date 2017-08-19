PROGRAM Newton1;
  { solve equation by Newton's method }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt;  { Crt for non-windows version }

VAR
    X, X2: Real;
  AllDone: Boolean;
    Error: Boolean;

PROCEDURE Func(X: Real;

VAR Fx, Dfx: Real);

BEGIN
  Fx := X * X - 2.0;
  Dfx := 2.0 * X
END;  { Func }

PROCEDURE Newton(VAR X: Real);

CONST
  Tol   = 1.0E-6;

VAR
  Fx, Dfx, Dx, X1: Real;

BEGIN  { Newton }
  REPEAT
    X1 := X;
    Func(X, Fx, Dfx);
    Dx := Fx / Dfx;
    X := X1 - Dx;
    WriteLn('X= ', X1:8:5,', Fx= ', Fx:12,', Dfx= ', Dfx:8:5)
  UNTIL  Abs(Dx) <= Abs(Tol * X)
END; { Newton }

BEGIN { main program }
  WriteLn;
  X := 2.0;  { first approximation }
  Newton(X);
  WriteLn; WriteLn('The solution is ', X:9:5);
  WriteLn; Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
END.