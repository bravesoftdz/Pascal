PROGRAM Besy;
  { evaluation of Bessel functions }
  { of the second kind }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt;  { Crt for non-windows version }

VAR
  X, Ordr, Pi2: Real;
  Done: Boolean;

FUNCTION Bessy(X, N: Real): Real;
 { cylindrical Bessel function }
 { of the second kind }

CONST
  Small = 1.0E-8;
  Euler = 0.57721566;

VAR
  J: Integer;
  X2, Sum, Sum2, T, T2, Ts, Term, XX,
  Y0, Y1, Ya, Yb, Yc, Ans, A, B: Real;

BEGIN  { function Bessy }
  IF X < 12 THEN
    BEGIN
      XX := 0.5 * X;
      X2 := XX * XX;
      T := Ln(XX) + Euler;
      Sum := 0.0;
      Term := T;
      Y0 := T;
      J := 0;
      REPEAT
        J := J + 1;
        IF J <> 1 THEN Sum := Sum + 1/(J-1);
        Ts := T - Sum;
        Term := -X2*Term/(J*J) * (1 - 1/(J*Ts));
        Y0 := Y0 + Term
      UNTIL Abs(Term) < Small;
      Term := XX * (T - 0.5);
      Sum := 0.0;
      Y1 := Term;
      J := 1;
      REPEAT
        J := J + 1;
        Sum := Sum + 1/(J-1);
        Ts := T - Sum;
        Term := (-X2*Term) / (J*(J-1))*
             ((Ts - 0.5/J) / (Ts + 0.5/(J-1)));
        Y1 := Y1 + Term
      UNTIL Abs(Term) < Small;
      Y0 := Pi2 * Y0;
      Y1 :=  Pi2 * ( Y1 - 1/X);
      IF N = 0.0 THEN
        Ans := Y0
      ELSE IF N = 1.0 THEN 
        Ans := Y1
      ELSE
        BEGIN { find Y by recursion }
          Ts := 2.0/X;
          Ya := Y0;
          Yb := Y1;
          FOR J := 2 TO Trunc(N + 0.01) DO
            BEGIN
              Yc := Ts * (J-1) * Yb - Ya;
              Ya := Yb;
              Yb := Yc
            END;
          Ans := Yc
        END;
      Bessy := Ans;
    END  { X < 12 }
  ELSE  { X > 11, asymptotic expansion }
    Bessy := Sqrt(2/(Pi*X))*Sin(X - Pi/4 - N*Pi/2)
END; { function Bessy }

BEGIN { main program }
  Pi2 := 2.0/Pi;
  Done := False;
  WriteLn;
  REPEAT
    Write(' Order? ');
    ReadLn( Ordr);
    IF Ordr < 0.0 THEN 
      Done := True
    ELSE
      BEGIN
        REPEAT
          Write(' Arg? ');
          ReadLn( X)
        UNTIL X >= 0.0;
        WriteLn(' Y Bessel is ', Bessy(X, Ordr):8:4)
      END  { IF }
  UNTIL Done;
  DoneWinCrt { for Windows version only }
END.