PROGRAM Testsort;
  { test speed of sorting routine }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt;  { Crt for non-windows version }

CONST
  Beep = #7;
  Max = 1000;

TYPE
  Sort_Var = Real;
  Ary = ARRAY[1..Max] OF Sort_Var;

VAR
      X: Ary;
   N, I: Integer;
  YesNo: Char;

PROCEDURE Print;

VAR
  I: Integer;

BEGIN
  WriteLn;
  FOR I := 1 TO N DO
    BEGIN
      Write(X[I]:7:0);
      IF (I MOD 10) = 0 THEN WriteLn
    END
END;

{$I swap.pas} {Listing 6.2}
{$I sort.pas} {Listing 6.3, 6.4, or 6.5}

BEGIN  { main program }
  REPEAT
    REPEAT
      Write(' How many numbers? ');
      ReadLn(N)
    UNTIL N <= Max;
    FOR I :=1 TO N DO
      X[I] := 1000*Random;
    Print;
    Write(Beep);
    Sort(X, N); { random numbers }
    Write(Beep);
    Print; WriteLn(' Random');
    Write(Beep);
    Sort(X, N);  { sorted numbers }
    Write(Beep);
    Print; WriteLn(' sorted');
    FOR I := 1 TO N DO
      X[I] := N + 1 - I;
    Write(Beep);
    Sort(X, N);  { reversed numbers }
    Write(Beep);
    Print; WriteLn(' reversed');
    Write(' More? ');
    ReadLn(YesNo)
  UNTIL (UpCase(YesNo) <> 'Y');
END.