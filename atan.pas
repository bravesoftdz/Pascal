FUNCTION Atan(X, Y: Real): Real;
 { arctan in degrees }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

CONST
  Pi180 = 57.2957795;

VAR
  A: Real;

BEGIN { Function Atan }
  IF X = 0.0 THEN
    IF Y = 0.0 THEN Atan := 0.0
    ELSE Atan := 90.0
  ELSE  { X <> 0 }
    IF Y = 0.0 THEN  Atan := 0.0
    ELSE  { X and Y <> 0 }
      BEGIN
        A := ArcTan(Abs(Y / X)) * Pi180;
        IF X > 0.0 THEN
          IF Y > 0.0 THEN Atan := A  { X, Y > 0 }
          ELSE  Atan := -A { X>0, Y<0 }
        ELSE    { X < 0 }
          IF Y > 0.0 THEN Atan := 180.0 - A  { X<0, Y>0 }
          ELSE  Atan := 180.0 + A  { X, Y < 0 }
      END  { ELSE }
END; { Function Atan }