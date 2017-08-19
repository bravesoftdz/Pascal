PROGRAM Nlin3;
  { least-squares fit for diffusion of Zn in Cu }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES WinCrt;  { Crt for non-windows version }

CONST
  Maxr = 20;    { data points }
  Maxc = 4;     { polynomial terms }
  R    = 1.987; { gas constant }

TYPE
  Index = 1..Maxr;
  Ary   = ARRAY[Index] OF Real;
  Arys  = ARRAY[1..Maxc]  OF Real;
  Ary2  = ARRAY[1..Maxr, 1..Maxc] OF Real;

VAR
  X, Y, Y_Calc, T, D, Ex: Ary;
  Coef: Arys; { solution vector }
  I, N, Nrow, Ncol: Integer;
  Done, Error: Boolean;
  Correl_Coef, A, B, X2, SRS: Real;

PROCEDURE Get_Data(VAR X, Y: Ary;
                      VAR N: Integer);
{ Get values for N and arrays T, D }

VAR
  I: Integer;

BEGIN
  N := 7;
  T[1]:=  600.0; D[1]:= 1.4E-12;
  T[2]:=  650.0; D[2]:= 5.5E-12;
  T[3]:=  700.0; D[3]:= 1.8E-11;
  T[4]:=  750.0; D[4]:= 6.1E-11;
  T[5]:=  800.0; D[5]:= 1.6E-10;
  T[6]:=  850.0; D[6]:= 4.4E-10;
  T[7]:=  900.0; D[7]:= 1.2E-9;
  FOR I := 1 TO N DO
    BEGIN
      X[I] := 1.0/(T[I] + 273);
      Y[I] := D[I]
    END
END; { procedure Get_Data }

PROCEDURE Write_Data;
{ display the answers }

VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn('  I   T C       D ',
        '           D Calc');
  FOR I := 1 TO N DO
    WriteLn(I:3, T[I]:6:0,'  ',D[I]:12,
         '   ', Y_Calc[I]:12);
  WriteLn; WriteLn(' Coefficients');
  WriteLn(Coef[1]:12, '     Constant term');
  FOR I := 2 TO Ncol DO
    WriteLn(Coef[I]:12); { other terms }
  WriteLn;
  WriteLn(' D0 = ', A:7:2,' cm sq/sec.');
  WriteLn(' Q = ',(-R*B/1000):8:2, ' kcal/mole');
  WriteLn; WriteLn(' SRS = ', SRS:8:4)
END; { Write_Data }

PROCEDURE Func( B: Real;
      VAR Fb, Dfb: Real);

VAR
  I: Integer;
  S1, S2, S3, S4, S5, S6,
  Ex1, Ex2, Xi, X2, Yi, Y2: Real;

BEGIN
  S1 := 0.0;
  S2 := 0.0;
  S3 := 0.0;
  S4 := 0.0;
  S5 := 0.0;
  S6 := 0.0;
  FOR I:= 1 TO N DO
    BEGIN
      Xi := X[I];
      X2 := Xi * Xi;
      Yi := Y[I];
      Y2 := Yi * Yi;
      Ex1 := Exp(B * Xi);
      Ex[I] := Ex1;
      Ex2 := Ex1 * Ex1;
      S1 := S1 + Xi * Ex2/Y2;
      S2 := S2 + Ex1/Yi;
      S3 := S3 + Xi * Ex1/Yi;
      S4 := S4 + Ex2/Y2;
      S5 := S5 + 2.0 * X2 * Ex2/Y2;
      S6 := S6 + X2 * Ex1/Yi
    END;
  Fb := S1*S2 - S3*S4;
  Dfb := S2*S5 - S1*S3 - S4*S6;
  A := S2/S4
END; { Func }

PROCEDURE Newton(VAR X: Real);

CONST
  Tol = 1.0E-6;
  Max = 20;

VAR
  I: Integer;
  Fx, Dfx, Dx, X1: Real;

BEGIN  { Newton }
  Error := False;
  I := 0;
  REPEAT
    I := I + 1;
    X1 := X;
    Func(X, Fx, Dfx);
    IF Dfx = 0.0 THEN
      BEGIN
        Error := True;
        X := 1.0;
        WriteLn('ERROR: slope zero')
      END
    ELSE
      BEGIN
        Dx := Fx / Dfx;
        X := X1 - Dx;
      END
  UNTIL 
    Error  OR
    (I > Max) OR
    (Abs(Dx) <= Abs(Tol * X));
  IF I > Max THEN
    BEGIN
      WriteLn ('ERROR: no convergence in ',
         Max, ' loops');
      Error := True
    END
END; { Newton }

PROCEDURE Nlin(X, Y: Ary;
         VAR Y_Calc: Ary;
                  N: Integer);
{ fit the diffusion equation through
   N sets of X and Y pairs of points }

VAR
  Resid: Ary;
  I: Integer;
  Xi, Yi, Sum_X,
  Sum_Y, Sum_Y2, B1,
  Sum_Xy, Sum_X2: Real;

BEGIN { Nlin }
  Ncol := 2; { two terms }
  Sum_X := 0.0;
  Sum_Y := 0.0;
  Sum_Xy := 0.0;
  Sum_X2 := 0.0;
  FOR I := 1 TO N DO
    BEGIN
      Xi := X[I];
      Yi := Ln(Y[I]);
      Sum_X := Sum_X + Xi;
      Sum_Y := Sum_Y + Yi;
      Sum_Y2 := Sum_Y2 + Yi*Yi;
      Sum_Xy := Sum_Xy + Xi*Yi;
      Sum_X2 := Sum_X2 + Xi*Xi
    END;
  B := (Sum_Xy - Sum_X*Sum_Y/N) /
       (Sum_X2 - Sqr(Sum_X)/N);
  Newton(B);
  Coef[1] := A;
  Coef[2] := B;
  SRS := 0.0;
  FOR I := 1 TO N DO
    BEGIN
      Y_Calc[I] := A * Ex[I];
      IF Y[I] <> 0.0 THEN
        Resid[I] := Y_Calc[I] / Y[I] - 1.0
      ELSE 
        Resid[I] := Y[I] / Y_Calc[I] - 1.0;
      SRS := SRS + Sqr(Resid[I])
    END
END; { Nlin }

BEGIN  { main program }
  Get_Data (X, Y, N);
  Nlin(X, Y, Y_Calc, N);
  Write_Data; Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt  { for Windows version only }
END.