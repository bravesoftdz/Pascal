PROCEDURE Write_Data;
{ print out the answers }

VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn('  I      X       Y     Y CALC');
  FOR I := 1 TO N DO
    WriteLn(I:3, X[I]:8:1, Y[I]:9:2, Y_Calc[I]:9:2);
  WriteLn
END; { Write_Data }