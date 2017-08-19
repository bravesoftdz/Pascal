PROCEDURE MeanStd
            ( X: Ary;   { array of values }
              N: Integer;
       VAR Mean: Real;
    VAR Std_Dev: Real);
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

VAR
  I: Integer;
  Sum_X, Sum_Sq: Real;

BEGIN
  Sum_X := 0;
  Sum_Sq := 0;
  FOR I := 1 TO N DO
    BEGIN
      Sum_X := Sum_X + X[I];
      Sum_Sq := Sum_Sq + X[I] * X[I]
    END;
  Mean := Sum_X / N;
  Std_Dev :=
      Sqrt((Sum_Sq - Sqr( Sum_X) / N)/(N-1))
END; { procedure MeanStd }
