BEGIN     { main program }
  AllDone := False;
  REPEAT
    WriteLn; Write(' First guess: ');
    ReadLn(X);
    IF X < -19.0 THEN
      AllDone := True
    ELSE
      BEGIN
        Newton(X);
        WriteLn;
        WriteLn('The solution is ', X:9:5);
        WriteLn
      END
  UNTIL AllDone;
  DoneWinCrt { for Windows version only }
END.