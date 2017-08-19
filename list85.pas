PROCEDURE Func(X: Real;
     VAR Fx, Dfx: Real);

VAR
  E: Real;

BEGIN
  E := Exp(X);
  Fx := E - 4.0 * X;
  Dfx := E - 4.0
END; { Func }