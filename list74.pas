PROCEDURE Get_Data
        (VAR T   : Ary; { independent variable }
         VAR Cp  : Ary; { dependent variable }
         VAR Nrow: Integer); { length of vectors }
VAR
  I: Integer;

BEGIN
  Nrow := 10;
  FOR I := 1 TO Nrow DO
    T[I] := (I + 2)* 100;
  Cp[1]:=  7.02; Cp[2]:=  7.20;
  Cp[3]:=  7.43; Cp[4]:=  7.67;
  Cp[5]:=  7.88; Cp[6]:=  8.06;
  Cp[7]:=  8.21; Cp[8]:=  8.34;
  Cp[9]:=  8.44; Cp[10]:= 8.53
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
     Xmatr: Ary2; { data matrix }
         A: Ary2s; { coefficient matrix }
         G: Arys;  { constant vector }
     Error: Boolean;
  I, J, Nm: Integer;
  Xi, Yi, Yc, SRS, SEE,
  Sum_Y, Sum_Y2: Real;

BEGIN       { procedure Linfit }
  Ncol := 3; { number of terms }
  FOR I := 1 TO Nrow DO
    BEGIN   { Setup X matrix }
      Xi := X[I];
      Xmatr[I, 1] := 1.0;  { first column }
      Xmatr[I, 2] := Xi;   { second column }
      Xmatr[I, 3] := 1.0/Sqr(Xi) { third column }
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
  IF Nrow = Ncol THEN Nm := 1
  ELSE Nm := Nrow - Ncol;
  SEE := Sqrt(SRS / Nm);
  FOR I := 1 TO Ncol DO   { errors in solution }
    Sig[I] := SEE * Sqrt(A[I, I])
END; { Linfit }