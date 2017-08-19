PROGRAM Newton4;
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES WinCrt;  { Crt for non-windows version }
VAR
  X, X2  : Real;
  AllDone: Boolean;
  Error  : Boolean;

PROCEDURE Func (X: Real; VAR Fx, Dfx: Real);
BEGIN
  Fx := X * X - 2.0;
  Dfx := 2.0 * X
END; { Func }

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

BEGIN     { main program }
  AllDone := False;
  REPEAT
    WriteLn; Write (' First guess: ');
    ReadLn( X);
    IF X < -19.0 THEN AllDone := True
    ELSE
      BEGIN
        Newton(X);
        WriteLn;
        IF NOT Error THEN
           WriteLn('The solution is ', X:9:5);
        WriteLn
      END
  UNTIL AllDone;
  DoneWinCrt { for Windows version only }
END.
