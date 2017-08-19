PROCEDURE Linfit(X, Y: Ary;
           VAR Y_Calc: Ary;
           VAR A, B  : Real;
                    N: Integer);
{ generate a straight line for X-Y }

VAR
  I: Integer;

BEGIN  { Linfit }
   A := 2.0;
   B := 5.0;
   FOR I := 1 TO N DO
      Y_Calc[I] := A + B * X[I]
END;  { Linfit }