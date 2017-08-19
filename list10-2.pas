PROGRAM Diffus;
  { least-squares fit for diffusion of Zn in Cu }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES WinCrt; { Crt for non-windows version }

CONST
  Maxr = 20;    { data points }
  Maxc = 4;     { polynomial terms }
  R    = 1.987; { gas constant }

TYPE
  FltPt = Real;
  Ary   = ARRAY[1..Maxr] OF FltPt;
  Arys  = ARRAY[1..Maxc] OF FltPt;
  Ary2  = ARRAY[1..Maxr, 1..Maxc] OF FltPt;
  Ary2s = ARRAY[1..Maxc, 1..Maxc] OF FltPt;

VAR
  X, Y, Y_Calc, T, D, Resid: Ary;
         Coef, Sig: Arys;
        Nrow, Ncol: Integer;
  Correl_Coef, SRS: Real;

PROCEDURE Get_Data(VAR X, Y, T, D: Ary;
                         VAR Nrow: Integer);
{ Get values for Nrow and arrays T, D }

VAR
  I: Integer;

BEGIN
  Nrow := 7;
  T[1]:=  600.0; D[1]:= 1.4E-12;
  T[2]:=  650.0; D[2]:= 5.5E-12;
  T[3]:=  700.0; D[3]:= 1.8E-11;
  T[4]:=  750.0; D[4]:= 6.1E-11;
  T[5]:=  800.0; D[5]:= 1.6E-10;
  T[6]:=  850.0; D[6]:= 4.4E-10;
  T[7]:=  900.0; D[7]:= 1.2E-9;
  FOR I := 1 TO Nrow DO
    BEGIN
      X[I] := 1.0/(T[I] + 273.0);
      Y[I] := Ln(D[I])
    END
END; { procedure Get_Data }

PROCEDURE Write_Data;
{ display the answers }

VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn;
  WriteLn('  I   T C        D        ',
        '   D Calc');
  FOR I := 1 TO Nrow DO
    WriteLn(I:3, T[I]:6:0,'  ',D[I]:12, '  ',
      Y_Calc[I]:12);
  WriteLn;
  WriteLn('coefficients');
  WriteLn(Coef[1]:12, '       Constant term');
  FOR I := 2 TO Ncol DO
    WriteLn
      (Coef[I]:12);     { other terms }
  WriteLn;
  WriteLn(' D0 = ', (Exp(Coef[1])):7:2,' cm sq/sec.');
  WriteLn(' Q = ', (-R * Coef[2] / 1000.0):8:2,
           ' kcal/mole');
  WriteLn; WriteLn(' SRS = ', SRS:7:3)
END; { Write_Data }

{$I SQUARE}  {Listing 3.2}
{$I GAUSSJ}  {Listing 4.4}

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

VAR
  Xmatr   : Ary2;  { Data matrix }
  A       : Ary2s; { coefficient matrix }
  G       : Arys;  { constant vector }
  Error   : Boolean;
  I, J, Nm: Integer;
  SEE, A1 : Real;

BEGIN             { procedure Linfit }
  Ncol := 2;  { number of terms }
  FOR I := 1 TO Nrow DO
    BEGIN   { set up X matrix }
      Xmatr[I, 1] := 1.0;  { first column }
      Xmatr[I, 2] := X[I]  { second column }
    END;
  Square(Xmatr, Y, A, G, Nrow, Ncol);
  Gaussj(A, G, Coef, Ncol, Error);
  SRS := 0.0;
  A1 := Exp(Coef[1]);
  FOR I := 1 TO Nrow DO
    BEGIN
      Y_Calc[I] := A1 * Exp(Coef[2] * X[I]);
      IF Y[I] <> 0.0 THEN 
        Resid[I] := Y_Calc[I] / Y[I] - 1.0
      ELSE
        Resid[I] := Y[I] / Y_Calc[I] - 1.0;
      SRS := SRS + Sqr(Resid[I])
    END
END; { Linfit }

BEGIN         { main program }
  Get_Data(X, Y, T, D, Nrow);
  Linfit(X, Y, Y_Calc, Resid, Coef, Sig, Nrow, Ncol);
  Write_Data;  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.