PROGRAM Determ;
 { the determinant of a 3-by-3 matrix }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt; { Crt for non-windows version}

TYPE
  Ary2  = ARRAY[1..3, 1..3] OF Real;

VAR
  A: Ary2;
  N: Integer;
  YesNo: Char;
  D: Real;

PROCEDURE Get_Data(VAR A: Ary2;
                   VAR N: Integer);
{ get values for N and arrays X, Y }

VAR
  I, J: Integer;

BEGIN
  N := 3;
  WriteLn;
  FOR I := 1 TO N DO
    BEGIN
      FOR J := 1 TO N DO
        BEGIN
          Write( J:3, ': ');
          ReadLn( A[I,J])
        END  { J loop }
    END; { I loop }
  WriteLn;
  FOR I:= 1 TO N  DO
    BEGIN
      FOR J:= 1 TO N DO
        Write( A[I,J]:7:4, '  ');
      WriteLn
    END;
  WriteLn
END; { procedure Get_Data }

FUNCTION Deter (A: Ary2): Real;
{ calculate the determinant of a 3-by-3 matrix }

VAR
  Sum: Real;

BEGIN
  Sum := A[1,1] * (A[2,2]*A[3,3] - A[3,2]*A[2,3])
       - A[1,2] * (A[2,1]*A[3,3] - A[3,1]*A[2,3])
       + A[1,3] * (A[2,1]*A[3,2] - A[3,1]*A[2,2]);
  Deter := Sum
END;

BEGIN  { main program }
  REPEAT
    Get_Data (A, N);
    D := Deter(A);
    WriteLn( 'The determinant is ', D:12);
    WriteLn;
    Write(' More? ');
    ReadLn( YesNo)
  UNTIL (UpCase(YesNo) <> 'Y');
END.
