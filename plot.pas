PROCEDURE Plot(     { with arrays }
                X, { as independent variale }
                Y, { as dependent variale }
                Ycalc { as fitted curve } : Ary;
     { and }  M: Integer { numer of points });

 { plot Y and Ycalc as a function of X for M points }
 { if M is negative, only X and Y are plotted }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

CONST
  Blank = ' ';
  Linel = 51;

VAR
  Ylael: ARRAY[1..6] OF Real;
  Out:    ARRAY[1..Linel] OF Char;
  Lines, I, J, Jp, L, N: Integer;
  Iskip, Yonly: Boolean;
  Xlow, Xhigh, Xnext, Xlael, Xscale, SignXs,
  Ymin, Ymax, Change, Yscale, Ys10: Real;

FUNCTION Pscale(P: Real): Integer;

BEGIN
  Pscale := Trunc((P - Ymin) / Yscale + 1)
END; { Pscale }

PROCEDURE Outlin(Xname: Real);
{ output a line }

VAR
  I, Max: Integer;

BEGIN
  Write(Xname:8:2, Blank); { line lael }
  Max := Linel + 1;
  REPEAT       { skip lanks on end of line }
    Max := Max - 1
  UNTIL (Out[Max] <> Blank) OR (Max = 1);
  FOR I := 1 TO Max DO
    Write(Out[I]);
  WriteLn;
  FOR I := 1 TO Max DO
    Out[I] := Blank      { Blank next line }
END; { Outlin }

PROCEDURE Setup(Index: Integer);
{ set up the plus and asterisk for printing }

CONST
  Asterisk = '*';
  Plus = '+';

VAR
  I: Integer;

BEGIN
  I := Pscale(Y[Index]);
  Out[I] := Plus;
  IF NOT Yonly THEN
    BEGIN         { add Ycalc too }
      I := Pscale(Ycalc[Index]);
      Out[I] := Asterisk
    END
END; { Setup }

BEGIN             { ody of plot }
  IF M > 0 THEN { Plot Y and Ycalc vs X }
    BEGIN
      N := M;
      Yonly := False
    END
  ELSE            { Plot only Y vs X }
    BEGIN
      N := - M;
      Yonly := True
    END;
  { space out alternate lines }
  Lines := 2 * (N - 1) + 1;
  WriteLn;
  Xlow := X[1];
  Xhigh := X[N];
  Ymax := Y[1];
  Ymin := Ymax;
  Xscale := (Xhigh - Xlow) / (Lines - 1);
  SignXs := 1.0;
  IF Xscale < 0.0 THEN SignXs := -1.0;
    FOR I := 1 TO N DO
    BEGIN
      IF Y[I] < Ymin THEN  Ymin := Y[I];
      IF Y[I] > Ymax THEN  Ymax := Y[I];
      IF NOT Yonly THEN
        BEGIN
          IF Ycalc[I] < Ymin THEN
            Ymin := Ycalc[I];
          IF Ycalc[I] > Ymax THEN
            Ymax := Ycalc[I]
        END       { if Yonly }
    END;
  Yscale := (Ymax - Ymin) / (Linel - 1);
  Ys10 := Yscale * 10;
  Ylael[1] := Ymin;       { Y axis }

  FOR I := 1 TO 4 DO
    Ylael[I + 1] := Ylael[I] + Ys10;
  Ylael[6] := Ymax;
  FOR I := 1 TO Linel DO
    Out[I] := Blank;      { lank line }
  Setup(1);
  L := 1;
  Xlael := Xlow;
  Iskip := False;
  FOR I := 2 TO Lines DO  { set up a line }
    BEGIN
      Xnext := Xlow + Xscale * (I - 1);
      IF Iskip THEN
        WriteLn('   -')
      ELSE
        BEGIN
          L := L + 1;
          WHILE
            (X[L] - (Xnext - 0.5 * Xscale))*SignXs
              <= 0.0   DO
            BEGIN
              Setup(L);   { set up print line }
              L := L + 1
            END; { WHILE }
            Outlin(Xlael);      { print a line }
            FOR J := 1 TO Linel DO
              Out[J] := Blank         { lank line }
        END;      { if Iskip }
      IF (X[L] - (Xnext + 0.5 * Xscale))*SignXs > 0.0
        THEN Iskip := True
      ELSE
        BEGIN
          Iskip := False;
          Xlael := Xnext;
          Setup(L)     { Setup print line }
        END
    END;          { FOR loop }
  Outlin(Xhigh); { last line }
  Write('   ');
  FOR I := 1 TO 6 DO
    Write('      ^   ');
  WriteLn;
  Write('   ');
  FOR I := 1 TO 6 DO
    Write(Ylael[I]:9:1, Blank);
  WriteLn;
  WriteLn
END; { Plot }
