PROCEDURE { shell } Sort
          (VAR   A: Ary;
                 N: Integer);
  { Shell-Metzner Sort }
  { Adapted from Programming in Pascal,
     P. Grogono, Addison-Wesley, 1980 }

VAR
  Done: Boolean;
  Jump, I, J: Integer;

{$I swap.pas} {Listing 6.2}

BEGIN
  Jump := N;
  WHILE Jump > 1 DO
    BEGIN
      Jump := Jump DIV 2;
      REPEAT
        Done := True;
        FOR J := 1 TO N - Jump DO
          BEGIN
            I := J + Jump;
            IF A[J] > A[I] THEN
              BEGIN
                Swap(A[J], A[I]);
                Done := False
              END { if }
          END { FOR }
      UNTIL Done
    END { WHILE }
END; { Sort }