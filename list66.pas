PROGRAM SortRec;
  { sort alphabetic records stored on disk }
  { From Borland Pascal Programs for Scientists and Engineers }
  { by Alan R. Miller, Copyright C 1993, SYBEX Inc }

USES WinCrt; { Crt for non-windows version }

CONST
  Max = 200;

TYPE
  Sort_Var = STRING[120];
  Ary = ARRAY[1..Max] OF Sort_Var;

VAR
  X: Ary;
  N, I: Integer;
  Error: Boolean;
  Filename: STRING[14];
  Filvar1,Filvar2: Text;

PROCEDURE Get_Data;
  { read records from disk }

BEGIN {Get_Data}
   WriteLn;
   WriteLn(' Program to sort text files on disk ');
   REPEAT
     Write(' File to sort: ');
     ReadLn(Filename);
     Assign(Filvar1,Filename);
     {$I-}  {Turn off error checking}
     Reset(Filvar1);
     {$I+}  {Turn it back on}
   UNTIL IOresult = 0;
   N := 0;
   REPEAT
     N := N + 1;
     ReadLn(Filvar1,X[N])
   UNTIL Eof(Filvar1)
END; {Get_Data}

PROCEDURE Make_Fil;
 { Write records to disk }

BEGIN {Make_Fil}
  WriteLn;
  Write(' New file name: ');
  ReadLn(Filename);
  Assign(Filvar2,Filename);
  Rewrite(Filvar2);
  FOR I:= 1 TO N DO
     WriteLn(Filvar2,X[I]);
  Close(Filvar2);
END; {Make_Fil}

{$I SWAP} {Listing 6.2}
{$I SORT}  {Listing 6.3, 6.4, or 6.5}

BEGIN  { main program }
  WriteLn;
  Get_Data;
  Sort(X, N);
  Make_Fil;
  DoneWinCrt  { for Windows version only }
END.