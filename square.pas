PROCEDURE Square(X: Ary2;
                 Y: Ary;
             VAR A: Ary2s;
             VAR G: Arys;
         Nrow,Ncol: Integer);

 { matrix multiplication routine }
 { A = transpose X times X }
 { G = Y times X }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

VAR
  I, K, L: Integer;

BEGIN  { Square }
  FOR K := 1 TO Ncol DO
    BEGIN
      FOR L := 1 TO K DO
        BEGIN
          A[K,L] := 0;
          FOR I := 1 TO Nrow DO
            BEGIN
              A[K,L] := A[K,L] + X[I,L] * X[I,K];
              IF K <> L THEN A[L,K] := A[K,L]
            END
        END { L loop };
      G[K] := 0;
      FOR I := 1 TO Nrow DO
        G[K] := G[K] + Y[I] * X[I,K]
    END  { K loop }
END; { Square }
