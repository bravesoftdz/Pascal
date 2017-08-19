PROGRAM Least1;
  { parabolic least-squares fit }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt; { Crt for non-windows version }

CONST
  Maxr = 20;
  Maxc = 3;

TYPE
  Ary   = ARRAY[1..Maxr] OF Real;
  Arys  = ARRAY[1..Maxc] OF Real;
  Ary2s = ARRAY[1..Maxc, 1..Maxc] OF Real;

VAR
  X, Y, Y_Calc: Ary;
          Coef: Arys;
    Nrow, Ncol: Integer;
   Correl_Coef: Real;

{$I plot.pas} {Listing 5.2}

PROCEDURE Get_Data(VAR X, Y: Ary;
                   VAR Nrow: Integer);
{ Get values for Nrow and arrays X, Y }

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
END; { procedure Get_Data }

PROCEDURE Solve(A: Ary2s;
                Y: Arys;
        VAR  Coef: Arys;
             Nrow: Integer;
        VAR Error: Boolean);
VAR
     B: Ary2s;
  I, J: Integer;
   Det: Real;

FUNCTION Deter(A: Ary2s): Real;
{ calculate the determinant of a 3-by-3 matrix }

BEGIN   { function Deter }
  Deter := A[1,1] *(A[2,2]*A[3,3] - A[3,2]*A[2,3])
         - A[1,2] *(A[2,1]*A[3,3] - A[3,1]*A[2,3])
         + A[1,3] *(A[2,1]*A[3,2] - A[3,1]*A[2,2])
END;  { function Deter }

PROCEDURE Setup(VAR  B: Ary2s;
             VAR  Coef: Arys;
                     J: Integer);
VAR
  I: Integer;

BEGIN   { Setup }
  FOR I := 1 TO Nrow DO
    BEGIN
      B[I,J] := Y[I];
      IF J > 1 THEN B[I, J - 1] := A[I, J - 1]
    END;
    Coef[J] := Deter(B) / Det
END; { Setup }

BEGIN  { procedure Solve }
  Error := False;
  FOR I := 1 TO Nrow DO
    FOR J := 1 TO Nrow DO
      B[I,J] := A[I,J];
  Det := Deter(B);
  IF  Det = 0.0 THEN
    BEGIN
      Error := True;
      WriteLn(' ERROR: matrix singular')
    END
  ELSE
    BEGIN
      Setup(B, Coef, 1);
      Setup(B, Coef, 2);
      Setup(B, Coef, 3)
    END  { else }
END; { procedure Solve }

PROCEDURE Linfit(X, Y: Ary;
           VAR Y_Calc: Ary;
           VAR Coef  : Arys;
               Nrow  : Integer;
           VAR Ncol  : Integer);
{ least-squares fit to a parabola }
{ Nrow sets of X and Y pairs of points }

VAR
  A: Ary2s;
  G: Arys;
  I: Integer;
  Error: Boolean;
  Sum_X, Sum_Y, Sum_XY, Sum_X2,
  Sum_Y2, Xi, Yi, SXY ,SXX, SYY,
  Sum_X3, Sum_X4, Sum_2Y, Denom,
  SRS, X2: Real;

BEGIN  { Linfit }
  Ncol := 3; { polynomial terms }
  Sum_X := 0;
  Sum_Y := 0;
  Sum_XY := 0;
  Sum_X2 := 0;
  Sum_Y2 := 0;
  Sum_X3 := 0;
  Sum_X4 := 0;
  Sum_2Y := 0;
  FOR I := 1 TO Nrow DO
    BEGIN
      Xi := X[I];
      Yi := Y[I];
      X2 := Xi*Xi;
      Sum_X := Sum_X + Xi;
      Sum_Y := Sum_Y + Yi;
      Sum_XY := Sum_XY + Xi * Yi;
      Sum_X2 := Sum_X2 + X2;
      Sum_Y2 := Sum_Y2 + Yi * Yi;
      Sum_X3 := Sum_X3 + Xi * X2;
      Sum_X4 := Sum_X4 + X2 * X2;
      Sum_2Y := Sum_2Y + X2 * Yi
    END;
  A[1,1] := Nrow;
  A[2,1] := Sum_X;  A[1,2] := Sum_X;
  A[3,1] := Sum_X2; A[1,3] := Sum_X2;
  A[2,2] := Sum_X2; A[3,2] := Sum_X3;
  A[2,3] := Sum_X3; A[3,3] := Sum_X4;
  G[1] := Sum_Y;
  G[2] := Sum_XY;
  G[3] := Sum_2Y;
  Solve(A, G, Coef, Ncol, Error);
  IF Error THEN Halt;
  SRS := 0.0;
  FOR I := 1 TO Nrow DO
    BEGIN
      Y_Calc[I] := Coef[1] + Coef[2] * X[I] + Coef[3] * Sqr(X[I]);
      SRS := SRS + Sqr(Y[I] - Y_Calc[I])
    END;
  Correl_Coef :=
        Sqrt(1.0 - SRS/(Sum_Y2 -Sqr(Sum_Y)/Nrow))
END; { Linfit }

PROCEDURE Write_Data;
 { print out the answers }

VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn('  I      X       Y     Y CALC');
  FOR I := 1 TO Nrow DO
    WriteLn(I:3, X[I]:8:1, Y[I]:9:2, Y_Calc[I]:9:2);
  WriteLn; WriteLn(' Coefficients');
  FOR I := 1 TO Ncol DO
    WriteLn(Coef[I]:8:4);
  WriteLn;
  WriteLn(' Correlation coefficient is ',Correl_Coef:8:5)
END; { Write_Data }

BEGIN  { main program }
  Get_Data(X, Y, Nrow);
  Linfit(X, Y, Y_Calc, Coef, Nrow, Ncol);
  Write_Data;
  WriteLn(' Press Enter for plot');
  REPEAT UNTIL KeyPressed;
  Plot(X, Y, Y_Calc, Nrow);
  ReadLn; 
  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
END.