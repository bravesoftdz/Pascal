PROGRAM Least3;
  { Gauss-Jordan least-squares fit }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt; { Crt for non-windows version }

CONST
  Maxr = 20;      { data points }
  Maxc = 4;       { polynomial terms }

TYPE
  FltPt = Real;
  Ary   = ARRAY[1..Maxr] OF FltPt;
  Arys  = ARRAY[1..Maxc] OF FltPt;
  Ary2  = ARRAY[1..Maxr, 1..Maxc] OF FltPt;
  Ary2s = ARRAY[1..Maxc, 1..Maxc] OF FltPt;

VAR
  X, Y, Y_Calc, Resid: Ary;
    Coef, Sig: Arys;
   Nrow, Ncol: Integer;
  Correl_Coef: Real;
         Done: Boolean;

{$I square.pas} {Listing 3.2}
{$I Gaussj.pas} {Listing 4.4}
{$I plot.pas}   {Listing 5.2}

PROCEDURE Get_Data
        (VAR X   : Ary; { independent variable }
         VAR Y   : Ary; { dependent variable }
         VAR Nrow: Integer); { length of vectors }
VAR
  I: Integer;

BEGIN
  Nrow := 9;
  FOR I := 1 TO Nrow DO X[I] := I;
  Y[1]:=  2.07; 
  Y[2]:=  8.60;
  Y[3]:= 14.42; 
  Y[4]:= 15.80;
  Y[5]:= 18.92; 
  Y[6]:= 17.96;
  Y[7]:= 12.98; 
  Y[8]:=  6.45;
  Y[9]:=  0.27
END;  { procedure Get_Data }

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

BEGIN             { procedure Linfit }
  FOR I := 1 TO Nrow DO
    BEGIN   { Setup X matrix }
      Xi := X[I];
      Xmatr[I, 1] := 1.0;      { first column }
      FOR J := 2 TO Ncol DO    { other columns }
        Xmatr[I, J] := Xmatr[I,J-1] * Xi
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
END;  { Linfit }

PROCEDURE Write_Data;
{ print out the answers }

VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn('  I      X       Y     Y CALC    RESID');
  FOR I := 1 TO Nrow DO
    WriteLn(I:3, X[I]:8:1, Y[I]:9:2,
      Y_Calc[I]:9:2, Resid[I]:9:2);
  WriteLn;
  WriteLn('coefficients     errors');
  WriteLn(Coef[1]:12,'   ', Sig[1]:12,'  Constant term');
  FOR I := 2 TO Ncol DO
    WriteLn
      (Coef[I]:12,'   ', Sig[I]:12);   { other terms }
  WriteLn;
  WriteLn
    (' Correlation coefficient is ', Correl_Coef:8:5)
END;  { Write_Data }

BEGIN  { main program }
  Done := False;
  WriteLn;
  Get_Data(X, Y, Nrow);
  REPEAT
    REPEAT
      Write(' Order of polynomial fit? ');
      ReadLn(Ncol)
    UNTIL Ncol < Maxc;
    IF Ncol < 1 THEN 
      Done := True  { quit if Ncol < 1 }
    ELSE
      BEGIN
        Ncol := Ncol + 1; { order is one less }
        Linfit(X, Y, Y_Calc, Resid, Coef, Sig, Nrow, Ncol);
        Write_Data;
        WriteLn(' Press Enter for plot');
        REPEAT UNTIL KeyPressed;
        Plot(X, Y, Y_Calc, Nrow)
      END  { ELSE }
  UNTIL Done;
END.