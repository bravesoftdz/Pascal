PROCEDURE swap(VAR n, m : Real);
   {adapted from https://github.com/cancanf3/proyectos/blob/master/Swap.pas}

VAR
  tmp : Real;

BEGIN
  tmp := n;
  n := m;
  m := tmp;
END;