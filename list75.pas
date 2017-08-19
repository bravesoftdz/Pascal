PROCEDURE Get_Data
        (VAR T   : Ary; { independent variable }
         VAR P   : Ary; { dependent variable }
         VAR Nrow: Integer); { length of vectors }
VAR
  I: Integer;

BEGIN { Get_Data }
  Nrow := 10;
  FOR I := 1 TO Nrow DO
    T[I] := (I + 6.0)* 100.0;
  P[1]:=  1.0E-9;    P[2]:=  5.598E-8;
  P[3]:=  1.234E-6;  P[4]:=  1.507E-5;
  P[5]:=  1.138E-4;  P[6]:=  6.067E-4;
  P[7]:=  2.512E-3;  P[8]:=  8.337E-3;
  P[9]:=  2.371E-2;  P[10]:= 5.875E-2;
  FOR I := 1 TO Nrow DO
    P[I] := Ln(P[I])  { take log of P }
END; { procedure Get_Data }

PROCEDURE Linfit(X,       { independent variable }
                 Y: Ary;  { dependent variable }
        VAR Y_Calc: Ary;  { calculated dependent variable }
        VAR Resid : Ary;  { array of residuals }
        VAR  Coef : Arys; { coefficients }
        VAR  Sig  : Arys; { errors in coefficients }
             Nrow : Integer;  { length of Ary }
        VAR  Ncol : Integer); { number of terms }

{ least-squares fit to }
{ Nrow sets of X and Y pairs of points. }
{ Separate procedures needed:
   Square and Gaussj }

VAR
     Xmatr: Ary2;  { data matrix }
         A: Ary2s; { coefficient matrix }
         G: Arys;  { constant vector }
     Error: Boolean;
  I, J, Nm: Integer;
  Xi, Yi, Yc, SRS, SEE,
  Sum_Y, Sum_Y2: Real;

BEGIN        { procedure Linfit }
  Ncol := 3; { number of terms }
  FOR I := 1 TO Nrow DO
    BEGIN   { Setup X matrix }
      Xi := X[I];
      Xmatr[I, 1] := 1.0;    { first column }
      Xmatr[I, 2] := 1.0/Xi; { second column }
      Xmatr[I, 3] := Ln(Xi)  { third column }
    END;

  Square(Xmatr, Y, A, G, Nrow, Ncol);
  Gaussj(A, G, Coef, Ncol, Error);
  Sum_Y := 0.0;
  Sum_Y2 := 0.0;
  SRS := 0.0;
  FOR I := 1 TO Nrow DO
    BEGIN
      Yi := Y[I];
      Yc := 0.0;
      FOR J := 1 TO Ncol DO
        Yc := Yc + Coef[J] * Xmatr[I, J];
      Y_Calc[I] := Yc;
      Resid[I] := Yc - Yi;
      SRS := SRS + Sqr(Resid[I]);
      Sum_Y := Sum_Y + Yi;
      Sum_Y2 := Sum_Y2 + Yi * Yi
    END;
  Correl_Coef :=
        Sqrt(1.0 - SRS /(Sum_Y2 - Sqr(Sum_Y) / Nrow));
  IF Nrow = Ncol THEN
    Nm := 1
  ELSE
    Nm := Nrow - Ncol;
  SEE := Sqrt(SRS / Nm);
  FOR I := 1 TO Ncol DO   { errors in solution }
    Sig[I] := SEE * Sqrt(A[I, I])
END; { Linfit }