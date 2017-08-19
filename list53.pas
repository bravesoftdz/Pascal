{$I PLOT} {Listing 5.2}

BEGIN  { main program }
  Done := False;
  REPEAT
    Get_Data(X, Y, N);
    IF NOT Done THEN
      BEGIN
        Write_Data;
        WriteLn(' Press Enter for plot');
        REPEAT UNTIL KeyPressed;
        Plot(X, Y, Y, -N);
        { more lines to be added here }
      END
  UNTIL Done;
  DoneWinCrt  { for Windows version only }
END.