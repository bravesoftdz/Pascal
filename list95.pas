PROGRAM Romb3;
  { integration by the Romberg method }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt;  { Crt for non-windows version }

CONST
  Tol = 1.0E-5;

VAR
  Done: Boolean;
  SumT, Sum, Upper, Lower: Real;

FUNCTION Fx(X: Real): Real;
{ find f(X) = 1 / Sqrt(X) }

BEGIN
  Fx := 1.0 / Sqrt(X)
END;

PROCEDURE Romb(Lower, Upper, Tol: Real;
                         VAR Ans: Real);
{ numerical integration by Romberg method }

VAR
  Nx: ARRAY[1..16] OF Integer;
  T:  ARRAY[1..136] OF Real;
  Done, Error: Boolean;
  Pieces, Nt,I, II, N, Nn,
  L, Ntra, K, M, J: Integer;
  Delta_X, C, Sum, Fotom, X: Real;

BEGIN
  Done := False;
  Error := False;
  Pieces := 1;
  Nx[1] := 1;
  Delta_X := (Upper-Lower)/Pieces;
  C := (Fx(Lower)+Fx(Upper))* 0.5;
  T[1] := Delta_X*C;
  N := 1;
  Nn := 2;
  Sum := C;
  REPEAT
    N := N+1;
    Fotom := 4.0;
    Nx[N] := Nn;
    Pieces := Pieces * 2;
    L := Pieces - 1;
    Delta_X := (Upper-Lower)/Pieces;
    { compute trapezoidal sum for 2^(N-1)+1 points }
    FOR II := 1 TO (L+1) DIV 2 DO
      BEGIN
        I := II * 2 - 1;
        X := Lower + I*Delta_X;
        Sum := Sum + Fx(X)
      END;
    T[Nn] := Delta_X*Sum;
    Ntra := Nx[N-1];
    K := N-1;
    { compute N-th row of T array }
    FOR M := 1 TO K DO
      BEGIN
        J := Nn+M;
        Nt := Nx[N-1]+M-1;
        T[J] := (Fotom*T[J-1] - T[Nt])/(Fotom-1.0);
        Fotom := Fotom*4.0
      END;
    IF N > 4 THEN
      BEGIN
        IF T[Nn+1] <> 0.0 THEN
           IF (Abs(T[Ntra+1] - T[Nn+1]) <= Abs(T[Nn+1]*Tol))
             OR (Abs(T[Nn - 1] - T[J]) <= Abs(T[J]*Tol)) THEN
               Done := True
           ELSE IF N > 15 THEN
             BEGIN
               Done := True;
               Error := True
             END
      END; { IF N > 4 }
    Nn := J+1
  UNTIL Done;
  Ans := T[J]
END; { Romberg }

BEGIN { main program }
  Lower := 0.1;  Upper := 1.0;
  WriteLn;
  SumT := 0.0;
  WriteLn(' new area    total area   lower',
        '   upper  limits');
  REPEAT
    Romb(Lower, Upper, Tol, Sum);
    Upper := Lower;
    Lower := 0.1 * Upper;
    SumT := SumT + Sum;
    WriteLn(Sum:9:6,'   ', SumT:9:5,
        '   ',Lower:12, '   ', Upper:12)
  UNTIL Abs(Sum) < Tol;
  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
  DoneWinCrt { for Windows version only }
END.