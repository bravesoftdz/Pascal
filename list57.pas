PROCEDURE Linfit(X, Y: Ary;
           VAR Y_Calc: Ary;
           VAR A, B  : Real;
                    N: Integer);

{ fit a straight line (Y_Calc) through
   N sets of X and Y pairs of points }

VAR
  I: Integer;
  Sum_X, Sum_Y, Sum_XY, Sum_X2,
  Sum_Y2, Xi, Yi, SXY, SXX, SYY: Real;

BEGIN  { Linfit }
  Sum_X := 0.0;
  Sum_Y := 0.0;
  Sum_XY := 0.0;
  Sum_X2 := 0.0;
  Sum_Y2 := 0.0;
  FOR I := 1 TO N DO
    BEGIN
      Xi := X[I];
      Yi := Y[I];
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
  A :=((Sum_X2 * Sum_Y - Sum_X * Sum_XY)/ N) / SXX;
  FOR I := 1 TO N DO
    Y_Calc[I] := A + B * X[I]
END; { Linfit }