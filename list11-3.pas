PROGRAM Erfd3;
 { evaluate the Gaussian error function }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt; { Crt for non-windows version }

VAR 
  X, Er, Ec, SqrtPi: Real;
  Done: Boolean;

FUNCTION Erf(X: Real): Real;
 { Infinite series expansion of the
  Gaussian error function }

CONST
  Tol = 1.0E-6;

VAR
  X2, Sum, Sum1, Term: Real;
  I: Integer;

BEGIN
  X2 := X*X;
  Sum := X;
  Term := X;
  I := 0;
  REPEAT
    I := I+1;
    Sum1 := Sum;
    Term := 2.0 * Term * X2/(1.0 + 2.0*I);
    Sum := Term + Sum1
  UNTIL Term < Tol * Sum;
  Erf := 2.0 * Sum * Exp(-X2) / SqrtPi
END; { Erf }

FUNCTION Erfc(X: Real): Real;
 { Complement of error function }

CONST
  SqrtPi = 1.7724538;
  Terms = 12;

VAR
  X2, U, V, Sum: Real;
  I: Integer;

BEGIN
  X2 := X*X;
  V := 1.0 / (2.0*X2);
  U := 1.0 + V*(Terms+1.0);
  FOR I := Terms DOWNTO 1 DO
    BEGIN
      Sum := 1.0 + I*V/U;
      U := Sum
    END;
  Erfc :=  Exp(-X2) / (X * Sum * SqrtPi)
END; { Erfc }

BEGIN { main program }
  SqrtPi := Sqrt(Pi);
  Done := False;
  WriteLn;
  REPEAT
    Write(' Arg? ');
    ReadLn( X);
    IF X < 0.0 THEN 
      Done := True
    ELSE
      BEGIN
        IF X = 0.0 THEN
          BEGIN
            Er := 0.0;
            Ec := 1.0
          END
        ELSE
          BEGIN
            IF X < 1.5 THEN
              BEGIN
                Er := Erf(X);
                Ec := 1.0 - Er
              END
            ELSE
              BEGIN
                Ec := Erfc(X);
                Er := 1.0 - Ec
              END   { IF }
          END;
        WriteLn(' X= ', X:6:2, ', Erf= ',
          Er:7:4, ', Erfc= ', Ec:12)
     END  { IF }
  UNTIL Done;
  DoneWinCrt { for Windows version only }
END.