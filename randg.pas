FUNCTION Randg(Mean, Sigma: Real): Real;
 { produce random numbers with a Gaussian distribution }
 { Mean and Sigma are supplied by calling program }
 { Function Random is required }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

VAR
  I: Integer;
  Sum: Real;

BEGIN
  Sum := 0;
  FOR I := 1 TO 12 DO
    Sum := Sum + Random;
  Randg := (Sum - 6) * Sigma  + Mean
END; { Function Randg }
