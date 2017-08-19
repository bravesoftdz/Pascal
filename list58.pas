PROGRAM Cfit5;
 { linear least-squares fit }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt;  { Crt for non-windows version}

CONST
  Max = 20;

TYPE
  Ary = ARRAY[1..Max] OF Real;

VAR
  X, Y, Y_Calc: Ary;
  N: Integer;
  Done: Boolean;
  A, B, Correl_Coef,
  Sigma_A, Sigma_B, SEE: Real;

PROCEDURE Get_Data(VAR X, Y: Ary;
                      VAR N: Integer);
{ Get values for N and arrays X, Y }
{ Y is randomly scattered about a straight line }

CONST
  A = 2.0;
  B = 5.0;

VAR
    I, J: Integer;
  Factor: Real;

BEGIN
  Write('Factor? ');
  ReadLn(Factor);
  IF Factor < 0.0 THEN 
    Done := True
  ELSE
    BEGIN
      REPEAT
        Write('How many points? ');
        ReadLn(N)
      UNTIL (N > 2) AND (N <=  Max);
      FOR I := 1 TO N DO
        BEGIN
          J := N +1 -I;
          X[I] := J;
          Y[I] :=
            (A + B*J)*(1.0 +(2.0*Random-1.0)*Factor)
        END   { FOR loop }
    END  { ELSE }
END; { procedure Get_Data }

PROCEDURE Write_Data;
{ print out the answers }

VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn('  I      X       Y     Y Calc');
  FOR I := 1 TO N DO
    WriteLn(I:3, X[I]:8:1,
            Y[I]:9:2, Y_Calc[I]:9:2);
  WriteLn;
  WriteLn(' Intercept is ', A:8:3,
          ', Sigma is ', Sigma_A:8:3);
  WriteLn('     Slope is ', B:8:2,
          ', Sigma is ', Sigma_B:8:3);
  WriteLn;
  WriteLn(' Correlation coefficient is ',
            Correl_Coef:7:4)
END; { Write_Data }

PROCEDURE Linfit(X, Y: Ary;
           VAR Y_Calc: Ary;
           VAR A, B  : Real;
                    N: Integer);
{ fit a straight line (Y_Calc) through
   N sets of X and Y pairs of points }

VAR
  I: Integer;
  Sum_X, Sum_Y, Sum_XY, Sum_X2,
  Sum_Y2, Xi, Yi, SXY ,SXX, SYY: Real;

BEGIN  { Linfit }
  Sum_X := 0.0;
  Sum_Y := 0.0;
  Sum_XY := 0.0;
  Sum_X2 := 0.0;
  Sum_Y2 := 0.0;
  FOR I := 1 TO N DO
    BEGIN
      Xi := X[I]; Yi := Y[I];
      Sum_X := Sum_X + Xi;
      Sum_Y := Sum_Y + Yi;
      Sum_XY := Sum_XY + Xi * Yi;
      Sum_X2 := Sum_X2 + Xi * Xi;
      Sum_Y2 := Sum_Y2 + Yi * Yi
    END;

  SXX := Sum_X2 - Sum_X * Sum_X/ N;
  SXY := Sum_XY - Sum_X * Sum_Y/ N;
  SYY := Sum_Y2 - Sum_Y * Sum_Y/ N;
  B := SXY / SXX;
  A :=
    ((Sum_X2 * Sum_Y - Sum_X * Sum_XY)/ N) / SXX;
  Correl_Coef := 
        SXY/ Sqrt(SXX * SYY);
  SEE :=
      Sqrt((Sum_Y2 - A*Sum_Y - B*Sum_XY) / (N-2));
  Sigma_B := SEE / Sqrt(SXX);
  Sigma_A := Sigma_B * Sqrt(Sum_X2 / N);
  FOR I := 1 TO N DO
    Y_Calc[I] := A + B * X[I]
END;  { Linfit }

{$I PLOT.PAS} {Listing 5.2}

BEGIN  { main program }
  Done := False;
  REPEAT
    Get_Data(X, Y, N);
    IF NOT Done THEN
      BEGIN
        Linfit(X, Y, Y_Calc, A, B, N);
        Write_Data;
        WriteLn(' Press Enter for plot');
        REPEAT UNTIL KeyPressed;
        Plot(X, Y, Y_Calc, N)
      END
  UNTIL Done;
  DoneWinCrt { for Windows version only }
END.