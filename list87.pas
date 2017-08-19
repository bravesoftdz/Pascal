PROCEDURE Func(T: Real;
     VAR Ft, Dft: Real);
 { the vapor pressure of lead }

CONST
  A = 18.19;
  B = -23180.0;
  C = -0.8858;
  LogP = -4.60517; { Ln(.01) }

BEGIN
  Ft := A + B / T + C * Ln(T) - LogP;
  Dft := - B /(T * T) + C / T
END;  { Func }