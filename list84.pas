PROCEDURE Newton(VAR X: Real);

CONST
  Tol   = 1.0E-6;
  Max = 20;

VAR
  Fx, Dfx, Dx, X1: Real;
  I: Integer;

BEGIN  { Newton }
  Error := False;
  I := 0;
  REPEAT
    I := I + 1;
    X1 := X;
    Func(X, Fx, Dfx);
    IF Dfx = 0.0 THEN
      BEGIN
        Error := True;
        X := 1.0;
        WriteLn('ERROR: slope zero')
      END
    ELSE
      BEGIN
        Dx := Fx / Dfx;
        X := X1 - Dx;
        WriteLn
          ('X= ',X1, ', Fx= ',Fx, ', Dfx= ',Dfx)
      END
  UNTIL
    Error  OR
    (I >= Max) OR
    (Abs(Dx) <= Abs(Tol * X));
  IF I >= Max THEN
    BEGIN
      WriteLn
         ('ERROR: no convergence in ',
         Max, ' loops');
      Error := True
    END
END; { Newton }