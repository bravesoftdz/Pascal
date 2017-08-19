PROGRAM Erfd;
  { evaluation of the Gaussian error function }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt; { Crt for non-windows version }

VAR
  X, Ans, SqrtPi: Real;
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
  IF X = 0.0 THEN Erf := 0.0
  ELSE IF X > 4.0 THEN Erf := 1.0
  ELSE
    BEGIN
      X2 := X*X;
      Sum := X;
      Term := X;
      I := 0;
      REPEAT
        I := I+1;
        Sum1 := Sum;
        Term := 2.0 * Term * X2/(1.0 + 2.0*I);
        Sum  := Term + Sum1
      UNTIL Term < Tol * Sum;
      Erf := 2.0 * Sum * Exp(-X2) / SqrtPi
    END  { IF }
END; { Erf }

BEGIN  { main program }
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
        Ans := Erf(X);
        WriteLn('Erf of ', X:6:3,
          ' is ', Ans:9:5)
      END
  UNTIL Done;
  DoneWinCrt  { for Windows version only }
END.