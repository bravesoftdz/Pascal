PROGRAM Simq1;
 { Three simultaneous equations by Cramer's rule }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES Crt; { Crt for non-windows version}

CONST
  Rmax = 3; Cmax = 3;

TYPE
  Arys   = ARRAY[1..Cmax] OF Real;
  Ary2s  = ARRAY[1..Rmax, 1..Cmax] OF Real;

VAR
  Y, Coef: Arys;
        A: Ary2s;
        N: Integer;
    YesNo: Char;
    Error: Boolean;

PROCEDURE Get_Data(VAR A: Ary2s;
                   VAR Y: Arys;
                   VAR N: Integer);
 { Get values for N and arrays A, Y }

VAR
  I, J: Integer;

BEGIN  { procedure Get_Data }
  WriteLn;
  N := Rmax;
  FOR I := 1 TO N DO
    BEGIN
      WriteLn(' Equation ', I:3);
      FOR J := 1 TO N DO
        BEGIN
          Write(J:3, ': ');
          Read(A[I,J])
        END;
      Write(', C: ');
      ReadLn(Y[I])
    END;
  WriteLn;
  FOR I:= 1 TO N  DO
    BEGIN
      FOR J:= 1 TO N DO
        Write(A[I,J]:7:4, '  ');
      WriteLn(' : ', Y[I]:7:4)
    END;
  WriteLn
END; { procedure Get_Data }

PROCEDURE Write_Data;
{ print out the answers }

VAR
  I: Integer;

BEGIN  { Write_Data }
  FOR I := 1 TO N DO
    Write(Coef[I]:9:5);
  WriteLn
END; { Write_Data }

PROCEDURE Solve(A: Ary2s;
                 Y: Arys;
        VAR   Coef: Arys;
                 N: Integer;
        VAR  Error: Boolean);
VAR
     B: Ary2s;
   Det: Real;
  I, J: Integer;

FUNCTION Deter(A: Ary2s): Real;
  { the determinant of a 3-by-3 matrix }

VAR
  Sum: Real;

BEGIN   { function Deter }
  Sum := A[1,1]*(A[2,2]*A[3,3]- A[3,2]*A[2,3])
       - A[1,2]*(A[2,1]*A[3,3]- A[3,1]*A[2,3])
       + A[1,3]*(A[2,1]*A[3,2]- A[3,1]*A[2,2]);
  Deter := Sum
END; { function Deter }

PROCEDURE Setup(VAR B: Ary2s;
            VAR  Coef: Arys;
                    J: Integer);
VAR
  I: Integer;

BEGIN   { Setup }
  FOR I := 1 TO N DO
    BEGIN
      B[I,J] := Y[I];
      IF J > 1 THEN B[I,J-1] := A[I,J-1]
    END;
  Coef[J] := Deter(B) / Det
END; { Setup }

BEGIN  { procedure solve }
  Error := False;
  FOR I := 1 TO N DO
    FOR J := 1 TO N DO
      B[I,J] := A[I,J];
  Det := Deter(B);
  IF Det = 0.0 THEN
    BEGIN
      Error := True;
      WriteLn(' ERROR: matrix singular')
    END
  ELSE
    BEGIN
      Setup(B, Coef, 1);
      Setup(B, Coef, 2);
      Setup(B, Coef, 3)
    END  { ELSE }
END; { procedure solve }

BEGIN  { main program }
  WriteLn;
  WriteLn
    (' Simultaneous solution by Cramer-s rule');
  REPEAT
    Get_Data(A, Y, N);
    Solve(A, Y, Coef, N, Error);
    IF NOT Error THEN  Write_Data;
    WriteLn; Write(' More? ');
    ReadLn(YesNo)
  UNTIL (UpCase(YesNo) <> 'Y');
 END.
