PROGRAM Trap1;
 { integration by the trapezoidal method }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt;  { Crt for non-windows version }

VAR
    Done: Boolean;
  Pieces: Integer;
  Sum, Upper, Lower: Real;

FUNCTION Fx(X: Real): Real;
  { find f(X) = 1 / X }
BEGIN
  Fx := 1.0 / X
END;

PROCEDURE Trapez(Lower, Upper: Real;
                       Pieces: Integer;
                      VAR Sum: Real);
{ numerical integration by the trapezoidal method }
{ function is Fx, limits are Lower and Upper }
{ with number of regions equal to Pieces }
{ fixed partition is Delta_X, answer is Sum }

VAR
  I: Integer;
  X, Delta_X, Esum, Psum: Real;

BEGIN
  Delta_X := (Upper - Lower) / Pieces;
  Esum := Fx(Lower) + Fx(Upper);
  Psum := 0.0;
  FOR I := 1 TO Pieces - 1 DO
    BEGIN
      X := Lower + I*Delta_X;
      Psum := Psum + Fx(X)
    END;
  Sum := (Esum + 2.0*Psum) * Delta_X * 0.5
END; { Trapez }

BEGIN { main program }
  Done := False;
  Lower := 1.0;  Upper := 9.0;
  WriteLn;
  REPEAT
    Write('How many sections? ');
    ReadLn(Pieces);
    IF Pieces <= 0 THEN 
      Done := True
    ELSE
      BEGIN
        Trapez(Lower, Upper, Pieces, Sum);
        WriteLn(' area = ', Sum:9:5)
      END
  UNTIL Done;
  DoneWinCrt { for Windows version only }
END.