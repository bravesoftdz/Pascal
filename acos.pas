FUNCTION ArcCos(X: Real): Real;
 { Arc cosine in degrees }
 { Function Atan is required }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

BEGIN { Function ArcCos }
  IF X = 0.0 THEN  ArcCos := 90.0
  ELSE
    IF X = 1.0 THEN ArcCos := 0.0
    ELSE
      IF X = -1.0 THEN ArcCos := 180.0
      ELSE ArcCos := Atan( X/ Sqrt(1.0 - Sqr(X)),1.0)
END; { Function ArcCos }
