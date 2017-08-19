PROGRAM Tstbes;
  { test Bessel function }
  { the Gamma function is required }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt;  { Crt for non-windows version }

VAR
  Done: Boolean;
  X, Ordr: Real;

FUNCTION Gamma(X: Real): Real;
VAR
  I, J: Integer;
  Y, Gam: Real;

BEGIN    { Gamma function }
  IF X >= 0.0 THEN
    BEGIN
      Y := X + 2;
      Gam := Sqrt(2*Pi/Y)*Exp(Y*Ln(Y) + (1 - 1/(30*Y*Y))/(12*Y) - Y);
      Gamma := Gam/(X*(X+1))
    END
  ELSE  { X < 0 }
    BEGIN
      J := 0;
      Y := X;
      REPEAT
        J := J + 1;
        Y := Y + 1.0
      UNTIL Y > 0.0;
      Gam := Gamma(Y);
      FOR I := 0 TO J - 1 DO
        Gam := Gam/(X + I);
      Gamma := Gam
    END   { if }
END; { Gamma function }

FUNCTION Bessj(X, N: Real): Real;
  { cylindrical Bessel function }
  { of the first kind }
  { the Gamma function is required }

CONST
  Tol = 1.0E-5;

VAR
  I: Integer;
  Term, New_Term, Sum, X2: Real;

BEGIN { Bessj }
  X2 := X * X;
  IF (X = 0.0) AND (N = 1.0) THEN 
    Bessj := 0.0
  ELSE IF X > 15 THEN { asymptotic expansion }
    Bessj :=  Sqrt(2/(Pi*X))*Cos(X - Pi/4 - N*Pi/2)
  ELSE
    BEGIN { regular infinite series }
      IF N = 0.0 THEN
        Sum := 1.0
      ELSE 
        Sum := Exp(N*Ln(X/2))/Gamma(N+1.0);
      New_Term := Sum;
      I := 0;
      REPEAT
        I := I + 1;
        Term := New_Term;
        New_Term := -Term*X2*0.25/(I*(N + I));
        Sum := Sum + New_Term
      UNTIL Abs(New_Term) <= Abs(Sum * Tol);
      Bessj := Sum
    END  { if }
END;  { Bessj }

BEGIN  { main program }
  Done := False;
  REPEAT
    Write(' Order: ');
    ReadLn( Ordr);
    IF Ordr < -25.0 THEN 
      Done := True
    ELSE
      BEGIN
        Write(' X: ');
        ReadLn(X);
        WriteLn(' J Bessel is ', Bessj(X, Ordr):10:5)
      END
  UNTIL Done;
END.