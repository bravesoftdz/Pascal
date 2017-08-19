FUNCTION ArcSin(X: Real): Real;
 { Arc sine in degrees }
 { Function Atan is required }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

BEGIN { Function ArcSin }
  IF X = 0.0 THEN  ArcSin := 0.0
  ELSE
    IF X = 1.0 THEN ArcSin := 90.0
    ELSE
      IF X = -1.0 THEN ArcSin := -90.0
      ELSE ArcSin := Atan( 1.0, X/ Sqrt(1.0 - Sqr(X)))
END; { Function ArcSin }