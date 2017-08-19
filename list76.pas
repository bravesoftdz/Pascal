PROGRAM Least6;
 { linear least-squares fit for steam }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES WinCrt; { Crt for non-windows version }

CONST
  Maxr = 20; { data points }
  Maxc = 4;  { polynomial terms }

TYPE
  FltPt = Real;
  Ary   = ARRAY[1..Maxr] OF FltPt;
  Arys  = ARRAY[1..Maxc] OF FltPt;
  Ary2  = ARRAY[1..Maxr, 1..Maxc] OF FltPt;
  Ary2s = ARRAY[1..Maxc, 1..Maxc] OF FltPt;

VAR
  P, T, V, Y, Y_Calc, Resid: Ary;
    Coef, Sig: Arys;
   Nrow, Ncol: Integer;
  Correl_Coef: Real;

{$I SQUARE}  {Listing 3.2}
{$I GAUSSJ}  {Listing 4.4}

PROCEDURE Get_Data
        (VAR P, T: Ary; { independent variables }
         VAR V   : Ary; { dependent variable }
         VAR Nrow: Integer); { length of vectors }
VAR
  I: Integer;

BEGIN
  Nrow := 12;
  T[1]:=  400; P[1]:=  120; V[1]:=  4.079;
  T[2]:=  450; P[2]:=  120; V[2]:=  4.36;
  T[3]:=  500; P[3]:=  120; V[3]:=  4.633;
  T[4]:=  400; P[4]:=  140; V[4]:=  3.466;
  T[5]:=  450; P[5]:=  140; V[5]:=  3.713;
  T[6]:=  500; P[6]:=  140; V[6]:=  3.952;
  T[7]:=  400; P[7]:=  160; V[7]:=  3.007;
  T[8]:=  450; P[8]:=  160; V[8]:=  3.228;
  T[9]:=  500; P[9]:=  160; V[9]:=  3.44;
  T[10]:= 400; P[10]:= 180; V[10]:= 2.648;
  T[11]:= 450; P[11]:= 180; V[11]:= 2.85;
  T[12]:= 500; P[12]:= 180; V[12]:= 3.042;
  FOR I := 1 TO Nrow DO
    T[I] := T[I] + 460.0  { convert to Rankine }
END; { procedure Get_Data }

PROCEDURE Write_Data;
{ print out the answers }

VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn('  I    P      T      V       ',
            'Y      Y CALC     %RES');
  FOR I := 1 TO Nrow DO
    WriteLn(I:3, P[I]:7:1, T[I]:7:1, V[I]:7:3,
    Y[I]:9:2,Y_Calc[I]:9:2,(100.0* Resid[I]/Y[I]):9:2);
  WriteLn;
  WriteLn('coefficients    errors');
  WriteLn(Coef[1]:10,'    ', Sig[1]:10,'  Constant term');
  FOR I := 2 TO Ncol DO
    WriteLn(Coef[I]:10,'    ', Sig[I]:10); { other terms }
  WriteLn;
  WriteLn
    (' Correlation coefficient is ', Correl_Coef:8:5)
END; { Write_Data }

PROCEDURE Linfit
         (P, T, V : Ary;  { independent variables }
        VAR Y     : Ary;  { dependent variable }
        VAR Y_Calc: Ary;  { calculated dependent variable }
        VAR Resid : Ary;  { array of residuals }
        VAR  Coef : Arys; { coefficients }
        VAR  Sig  : Arys; { errors in coefficients }
             Nrow : Integer;  { length of Ary }
        VAR  Ncol : Integer); { number of terms }

{ fit an equation of state through
   Nrow sets of P, T, and V sets of points. }
{ Separate procedures needed:
   Square and Gaussj }

CONST
  R = 85.76; { gas constant for steam }

VAR
     Xmatr: Ary2;  { data matrix }
         A: Ary2s; { coefficient matrix }
         G: Arys;  { constant vector }
     Error: Boolean;
  I, J, Nm: Integer;
  Power, Yi, Yc, SRS,
  SEE, Sum_Y, Sum_Y2: Real;

BEGIN        { procedure Linfit }
  Ncol := 2; { number of terms }
  FOR I := 1 TO Nrow DO
    BEGIN   { Setup X matrix }
      Power :=  T[I];
      Xmatr[I, 1] := P[I] / Power; { first column }
      Xmatr[I, 2] := Sqrt(P[I]);   { second column }
      Y[I] := V[I] * P[I] - R * T[I] / 144.0
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

BEGIN      { main program }
  Get_Data(P, T, V, Nrow);
  Linfit(P,T,V,Y,Y_Calc,Resid,Coef,Sig,Nrow,Ncol);
  Write_Data;
  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt { for Windows version only }
END.