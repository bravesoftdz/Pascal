PROGRAM Gaus;
 { simultaneous solution by Gaussian elimination }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt; { Crt for non-windows version}

CONST
  Maxr = 8;
  Maxc = 8;

TYPE
  Arys  = ARRAY[1..Maxc] OF Real;
  Ary2s = ARRAY[1..Maxr, 1..Maxc] OF Real;

VAR
  Y, Coef: Arys;
        A: Ary2s;
     N, M: Integer;
    Error: Boolean;

PROCEDURE Get_Data(VAR A: Ary2s;
                   VAR Y: Arys;
                VAR N, M: Integer);
{ Get values for N and arrays A, Y }

VAR
  I, J: Integer;

BEGIN
  WriteLn;
  REPEAT
    Write(' How many equations? ');
    ReadLn(N);
    M := N
  UNTIL N < Maxr;
  IF N > 1 THEN
    BEGIN
      FOR I := 1 TO N DO
        BEGIN
          WriteLn(' Equation', I:3);
          FOR J := 1 TO N DO
            BEGIN
              Write(J:3, ': ');
              Read(A[I,J])
            END;
          Write(', C: ');
          ReadLn(Y[I]);
        END;
      WriteLn;
      FOR I:= 1 TO N DO
        BEGIN
          FOR J:= 1 TO M DO
            Write(A[I,J]:7:4, '  ');
          WriteLn(' : ', Y[I]:7:4)
        END;
      WriteLn
    END  { if N>1 }
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

PROCEDURE Gauss
              (A: Ary2s;
               Y: Arys;
        VAR Coef: Arys;
            Ncol: Integer;
       VAR Error: Boolean);
{ matrix solution by Gaussian Elimination }
{ Adapted from Gilder }

VAR
  B: Ary2s; { work array, Nrow,Ncol }
  W: Arys;  { work array, Ncol long }
  I, J, I1, K, L, N: Integer;
  Hold, Sum, T, Ab, Big: Real;

BEGIN
  Error := False;
  N := Ncol;
  FOR I := 1 TO N DO
    BEGIN { copy to work arrays }
      FOR J := 1 TO N DO
        B[I,J] := A[I,J];
      W[I] := Y[I]
    END;
  FOR I := 1 TO N - 1 DO
    BEGIN
      Big := Abs(B[I,I]);
      L := I;
      I1 := I + 1;
      FOR J := I1 TO N DO
        BEGIN { search for largest element }
          Ab := Abs(B[J,I]);
          IF Ab > Big THEN
            BEGIN
              Big := Ab;
              L := J
            END
        END;
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
                  Hold := B[L,J];
                  B[L,J] := B[I,J];
                  B[I,J] := Hold
                END;
              Hold := W[L];
              W[L] := W[I];
              W[I] := Hold
            END; { if L <> I }
          FOR  J := I1 TO N DO
            BEGIN
              T := B[J,I] / B[I,I];
              FOR K := I1 TO N DO
                B[J,K] := B[J,K] - T * B[I,K];
              W[J] := W[J] - T * W[I]
            END   { J loop }
       END   { if Big }
    END; { I loop }
  IF B[N,N] = 0.0 THEN 
    Error := True
  ELSE
    BEGIN
      Coef[N] := W[N] / B[N,N];
      I := N - 1;
      { back substitution }
      REPEAT
        Sum := 0.0;
        FOR J := I+1 TO N DO
          Sum := Sum + B[I,J] * Coef[J];
        Coef[I] := (W[I] - Sum) / B[I,I];
        I := I - 1
      UNTIL I = 0
    END; { IF B[N,N] = 0 }
  IF Error THEN 
    WriteLn('ERROR: Matrix singular ')
END; { Gauss }

BEGIN  { main program }
  WriteLn;
  WriteLn
    (' Simultaneous solution by Gauss elimination');
  REPEAT
    Get_Data(A, Y, N, M);
    IF N > 1 THEN
      BEGIN
        Gauss(A, Y, Coef, N, Error);
        IF NOT Error THEN  Write_Data
      END
  UNTIL N < 2;
  DoneWinCrt  { for Windows version only }
END.