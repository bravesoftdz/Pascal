PROCEDURE Func(X: Real;
     VAR Fx, Dfx: Real);

BEGIN
  Fx  := Sin(X) - 0.1 * X;
  Dfx := Cos(X) - 0.1
END; { Func }