
function res = strOrder(s1,s2)
	 
  l1 = length(s1);
  l2 = length(s2);
  i = 1;
  while (l1 > 0 && l2 > 0)
    if (s1(i) == s2(i))
      i++; l1--; l2--;
    elseif (s1(i) < s2(i))
      res = -1; return;
    else
      res = 1; return;
    end
  end  % while
 
  if (l1 == l2)
    res = 0;
  elseif (l1 < l2)
    res = -1;
  else
    res = 1;
  end

end % function str_order()
