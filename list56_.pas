BEGIN  { main program }
  Done := False;
  REPEAT
    Get_Data(X, Y, N);
    IF NOT Done THEN
      BEGIN
        Linfit(X, Y, Y_Calc, A, B, N);
        Write_Data;
        WriteLn(' Press Enter for plot');
        REPEAT UNTIL KeyPressed;
        Plot(X, Y, Y_Calc, N)
      END
  UNTIL Done;
  Writeln;
  Writeln('  Press Enter to end');
  REPEAT UNTIL KeyPressed;
END.