PROGRAM Fitpol;
  { fit to the ratio of two polynomials }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES WinCrt; { Crt for non-windows version }

CONST
  Maxr = 20; { data points }
  Maxc = 4; { polynomial terms }

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

PROCEDURE Get_Data
        (VAR X   : Ary; { independent variable }
         VAR Y   : Ary; { dependent variable }
         VAR Nrow: Integer); { length of vectors }

VAR
  I : Integer;

BEGIN
 {  Clausing Factors }
  Nrow := 10;
  X[1]:= 0.1;  Y[1]:=  0.9524;
  X[2]:= 0.2;  Y[2]:=  0.9092;
  X[3]:= 0.5;  Y[3]:=  0.8013;
  X[4]:= 1.0;  Y[4]:=  0.6720;
  X[5]:= 1.2;  Y[5]:=  0.6322;
  X[6]:= 1.5;  Y[6]:=  0.5815;
  X[7]:= 2.0;  Y[7]:=  0.5142;
  X[8]:= 3.0;  Y[8]:=  0.4201;
  X[9]:= 4.0;  Y[9]:=  0.3566;
  X[10]:= 6.0; Y[10]:= 0.2755
END; { procedure Get_Data }

PROCEDURE Write_Data;
{ display the answers }

VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn;
  WriteLn('  I      X       Y     Y CALC    RESID');
  FOR I := 1 TO Nrow DO
    WriteLn(I:3, X[I]:8:1, Y[I]:9:4,
      Y_Calc[I]:9:4, Resid[I]:9:4);
  WriteLn;
  WriteLn('coefficients    errors');
  WriteLn(Coef[1]:8:5, '    ', Sig[1]:13, '  Constant term');
  FOR I := 2 TO Ncol DO
    WriteLn
      (Coef[I]:8:5, '    ', Sig[I]:13);     { other terms }
  WriteLn;
  WriteLn(' Correlation coefficient is ', Correl_Coef:8:5)
END; { Write_Data }

{$I SQUARE} {Listing 3.2}
{$I GAUSSJ} {Listing 4.4}

PROCEDURE Linfit(X,      { independent variable }
                 Y: Ary; { dependent variable }
        VAR Y_Calc: Ary; { calculated dependent variable }
        VAR Resid : Ary;  { array of residuals }
        VAR  Coef : Arys; { coefficients }
        VAR  Sig  : Arys; { errors on coefficients }
             Nrow : Integer; { length of Ary }
        VAR  Ncol : Integer); { number of terms }

{ least-squares fit to }
{ Nrow sets of X and Y pairs of points }
{ Separate procedures needed:
   Square - form square coefficient matrix
   Gaussj - Gauss-Jordan elimination      }

VAR
  Xmatr   : Ary2;  { Data matrix }
  A       : Ary2s; { coefficient matrix }
  G       : Arys;  { constant vector }
  Error   : Boolean;
  I, J, Nm: Integer;
  Xi, Yi, Yc, SRS, SEE,
  Sum_Y, Sum_Y2: Real;

BEGIN             { procedure Linfit }
  Ncol := 4; { number of terms }
  FOR I := 1 TO Nrow DO
    BEGIN   { setup X matrix }
      Xi := X[I];
      Yi := Y[I];
      Xmatr[I, 1] := 1.0; { first column }
      Xmatr[I, 2] := -Xi*Yi;
      Xmatr[I, 3] := Xi;
      Xmatr[I, 4] := -Sqr(Xi)*Yi
    END;
  Square(Xmatr, Y, A, G, Nrow, Ncol);
  Gaussj(A, G, Coef, Ncol, Error);
  Sum_Y := 0.0;
  Sum_Y2 := 0.0;
  SRS := 0.0;
  FOR I := 1 TO Nrow DO
    BEGIN
      Xi := X[I];
      Yi := Y[I];
      Yc := Coef[1]
        +(-Coef[2]*Yi+Coef[3]-Coef[4]*Xi*Yi)*Xi;
      Y_Calc[I] := Yc;
      Resid[I] := Yc - Yi;
      SRS := SRS + Sqr(Resid[I]);
      Sum_Y := Sum_Y + Yi;
      Sum_Y2 := Sum_Y2 + Yi * Yi
    END;
  Correl_Coef :=  Sqrt(1.0 - SRS /
         (Sum_Y2 - Sqr(Sum_Y) / Nrow));
  IF Nrow = Ncol THEN 
    Nm := 1
  ELSE 
    Nm := Nrow - Ncol;
  SEE := Sqrt(SRS / Nm);
  FOR I := 1 TO Ncol DO   { errors in solution }
    Sig[I] := SEE * Sqrt(A[I, I])
END; { Linfit }

BEGIN  { main program }
  Get_Data(X, Y, Nrow);
  Linfit(X, Y, Y_Calc, Resid, Coef, Sig, Nrow, Ncol);
  Write_Data;  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt { for Windows version only }
END.