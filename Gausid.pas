PROGRAM Gausid;
{ Turbo Pascal program to perform
  simultaneous solution by Gauss-Seidel
  procedure Seid is included }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES
  Crt;

CONST
  Maxr = 8;
  Maxc = 8;

TYPE
  Ary   = ARRAY[1..Maxr] OF Real;
  Arys  = ARRAY[1..Maxc] OF Real;
  Ary2s = ARRAY[1..Maxr, 1..Maxc] OF Real;

VAR
      Y: Ary;
   Coef: Arys;
      A: Ary2s;
   N, M: Integer;
  Error: Boolean;

PROCEDURE Get_Data
     (VAR A: Ary2s;
      VAR Y: Ary;
   VAR N, M: Integer);
{ Get values for N and arrays A, Y }

VAR
  I, J: Integer;
BEGIN
  WriteLn;
  REPEAT
    Write(' How many equations? ');
    ReadLn(N)
  UNTIL N < Maxr;
  M := N;
  IF N > 1 THEN
    BEGIN
      FOR I := 1 TO N DO
        BEGIN
          WriteLn;
          WriteLn(' Equation', I: 3);
          FOR J := 1 TO N DO
            BEGIN
              Write(J:3, ': ');
              Read(A[I, J])
            END;
          Write(' C: ');
          Read(Y[I]);
        END;
      WriteLn;
      FOR I := 1 TO N DO
        BEGIN
          FOR J := 1 TO M DO
            Write(A[I, J]:7:4, '  ');
          WriteLn(' : ', Y[I]:7:4)
        END;
      WriteLn
    END  { if N>1 }
  ELSE IF N < 0 THEN N := - N;
  M := N
END; { procedure Get_Data }

PROCEDURE Write_Data;
     { print out the answers }
VAR
  I: Integer;

BEGIN
  FOR I := 1 TO M DO
    Write(Coef[I]:9:5);
  WriteLn
END; { Write_Data }

PROCEDURE Seid
           (A: Ary2s;
            Y: Ary;
     VAR Coef: Arys;
         Ncol: Integer;
    VAR Error: Boolean);
{ matrix solution by Gauss-Seidel }

CONST
  Tol = 1.0E-4;
  Max = 100;

VAR
  Done: Boolean;
  I, J, K, L, N: Integer;
  Nextc, Hold, Sum, Lambda, Ab, Big: Real;

BEGIN
  REPEAT
    Write(' Relaxation factor? ');
    ReadLn(Lambda)
  UNTIL (Lambda < 2.0) AND (Lambda > 0.0);
  Error := False;
  N := Ncol;
  FOR I := 1 TO N - 1 DO
    BEGIN
      Big := Abs(A[I, I]);
      L := I;
      FOR J := I + 1 TO N DO
        BEGIN
          { search for largest element }
          Ab := Abs(A[J, I]);
          IF Ab > Big THEN
            BEGIN
              Big := Ab;
              L := J
            END
        END; { J loop }
      IF Big = 0.0 THEN
        Error := True
      ELSE
        BEGIN
          IF L <> I THEN
            BEGIN
              { interchange rows to put }
              { largest element on diagonal }
              FOR J := 1 TO N DO
                BEGIN
                  Hold := A[L, J];
                  A[L, J] := A[I, J];
                  A[I, J] := Hold
                END;
              Hold := Y[L];
              Y[L] := Y[I];
              Y[I] := Hold
            END   { if L <> I }
        END       { if Big }
    END;          { I loop }
  IF A[N, N] = 0.0 THEN
    Error := True
  ELSE
    BEGIN
      FOR I := 1 TO N DO
        Coef[I] := 0.0; { initial guess }
      I := 0;
      REPEAT
        I := I + 1;
        Done := True;
        FOR J := 1 TO N DO
          BEGIN
            Sum := Y[J];
            FOR K := 1 TO N DO
              IF J <> K THEN
                Sum := Sum - A[J, K] * Coef[K];
            Nextc := Sum / A[J, J];
            IF Abs(Nextc - Coef[J]) > Tol THEN
              BEGIN
                Done := False;
                IF Nextc * Coef[J] < 0.0 THEN
                  Nextc := (Coef[J] + Nextc) * 0.5
              END;
            Coef[J] :=
              Lambda*Nextc + (1.0 - Lambda)*Coef[J];
            WriteLn(I:4, ',Coef(', J, ') =',Coef[J])
          END  { J loop }
      UNTIL Done OR (I > Max)
    END; { IF A[N,N] = 0 }
  IF I > Max THEN Error := True;
  IF Error THEN WriteLn('ERROR: Matrix singular ')
END; { Seid }

BEGIN             { main program }
  WriteLn;
  WriteLn(' Simultaneous solution by Gauss-Seidel');
  REPEAT
    Get_Data(A, Y, N, M);
    IF N > 1 THEN
      BEGIN
        Seid(A, Y, Coef, N, Error);
        IF NOT Error THEN Write_Data
      END
  UNTIL N < 2;
END.
