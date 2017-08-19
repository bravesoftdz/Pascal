PROGRAM Fitfile;
 { solution by Gauss-Jordan elimination }
 { Read data from disk file }
 { From Borland Pascal Programs for Scientists and Engineers }
 { by Alan R. Miller, Copyright C 1993, SYBEX Inc }
USES WinCrt;  {Crt for non-windows version}

CONST
  Maxr = 8;
  Maxc = 8;

TYPE
  FltPt = Real;
  Arys  = ARRAY[1..Maxc] OF FltPt;
  Ary2s = ARRAY[1..Maxr, 1..Maxc] OF FltPt;

VAR
     Y, Coef: Arys;
        A, B: Ary2s;
  N, M, I, J: Integer;
       Error: Boolean;
    Filename: STRING[14];
      Filvar: Text;
       YesNo: Char;

PROCEDURE Get_Data(VAR A: Ary2s;
                   VAR Y: Arys;
                VAR N, M: Integer);
{ Get values for N and arrays A, Y }

VAR
  I, J: Integer;

BEGIN { Get_Data }
   WriteLn;
   REPEAT
      Write(' Name of file: ');
      ReadLn(Filename);
      Assign(Filvar,Filename);
      {$I-}  {Turn off Error checking}
      Reset(Filvar);
      {$I+}  {Turn it back on}
   UNTIL IOresult = 0;
   ReadLn(Filvar, N);  { number of equations }
   M := N;
   WriteLn;
   WriteLn
    (' Simultaneous solution by Gauss-Jordan elimination');
   WriteLn('  ',N,' equations ');
   IF N > 1 THEN
    BEGIN
      FOR I := 1 TO N DO
        BEGIN
          FOR J := 1 TO N DO
              Read(Filvar, A[I,J]);
          ReadLn(Filvar, Y[I])   { clear line }
        END;
      FOR I:= 1 TO N  DO
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

{$I GAUSSJ}   {Listing 4.4}

BEGIN  { main program }
  WriteLn;
   REPEAT
    Get_Data(A, Y, N, M);
    IF N > 1 THEN
      BEGIN
        FOR I := 1 TO N DO
          FOR J := 1 TO N DO
            B[I,J] := A[I,J]; { Setup work array }
        Gaussj(B, Y, Coef, N, Error);
        IF NOT Error THEN Write_Data
      END;
    WriteLn; Write(' More? '); ReadLn( YesNo)
  UNTIL (UpCase(YesNo) <> 'Y');
  DoneWinCrt  { for Windows version only }
END.
