function output=variable(qc,file)
    disp("########################");
    disp("Ground Truth");
    disp("########################");    
    str = strsplit(file,".");
    c = str2num(str{1});
##    disp(c);
    
    resF = 0;
    if c >= 0 && c <= 25
      resF = 1;
    elseif c >= 100 && c <= 199
      resF = 2;
    elseif c >= 200 && c <= 253
      resF = 3;
    elseif c >= 1000 && c <= 1101
      resF = 4;
    elseif c >= 1102 && c <= 1359
      resF = 5;
    elseif c >= 1360 && c <= 1398
      resF = 6;
    elseif c >= 1399 && c <= 1593
      resF = 7;
    elseif c >= 1594 && c <= 1694
      resF = 8;
    elseif c >= 1695 && c <= 1792
      resF = 9;
    elseif c >= 1793 && c <= 1893
      resF = 10
    else {}
  end  
  
    resQ = 0;
    if qc >= 0 && qc <= 25
      resQ = 1;
    elseif qc >= 100 && qc <= 199
      resQ = 2;
    elseif qc >= 200 && qc <= 253
      resQ = 3;
    elseif qc >= 1000 && qc <= 1101
      resQ = 4;
    elseif qc >= 1102 && qc <= 1359
      resQ = 5;
    elseif qc >= 1360 && qc <= 1398
      resQ = 6;
    elseif qc >= 1399 && qc <= 1593
      resQ = 7;
    elseif qc >= 1594 && qc <= 1694
      resQ = 8;
    elseif qc >= 1695 && qc <= 1792
      resQ = 9;
    elseif qc >= 1793 && qc <= 1893
      resQ = 10;
    else {}
    end  
  
    disp("resF =");
    disp(resF);
    disp("resQ = ");
    disp(resQ);
  
    res = 0;
    if resF == resQ
      res = 1;
    endif
  
    output = res;
endfunction

##Image Classifications
##
##0-25        Class A
##100-199     Class B
##200-253     Class C
##1000-1101   Class D
##1102-1359   Class E
##1360-1398   Class F
##1399-1593   Class G
##1594-1694   Class H
##1695-1792   Class I
##1793-1893   Class J
