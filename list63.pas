PROCEDURE { bubble } Sort
        (VAR  A: Ary;
              N: Integer);
VAR
  I,J : Integer;
  Hold: Real;

BEGIN  { procedure Sort }
  FOR I := 1 TO N-1 DO
    FOR J := I + 1 TO N DO
      IF A[I] > A[J] THEN
        Swap(A[I], A[J])
END; { procedure Sort }