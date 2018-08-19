function variable(max, thres,precision_handle,recall_handle,fmeasure_handle)
##  disp("#################");
##  disp("Precision, Recall and FMeasure");
##  disp("#################");
  
  load("ch.mat");
  mat = color_histogram;
##  max = 15;
##  thres = 0.3;
  
  tp = 0;  
  fp = 0;
  fn = 0;
  tn = 0;
  for i=1:max    
    sim = mat{2,i};
    gt = mat{3,i};
    if sim > thres && gt == 1
      tp = tp + 1;
    elseif  sim > thres && gt == 0
      fp = fp + 1;
    elseif  sim < thres && gt == 1
      fn = fn + 1;
    elseif  sim < thres && gt == 0
      tn = tn + 1;
    endif
  endfor
  precision = tp / (tp + fp);
  recall = tp / (tp + fn);
  fmeasure = 1 / ( (thres/precision) + ((1-thres)/recall));
  set(precision_handle,'string',num2str(precision));    
  set(recall_handle,'string',num2str(recall));    
  set(fmeasure_handle,'string',num2str(fmeasure));    
##  disp(tp);
##  disp(fp);
##  disp(fn);
##  disp(tn);
##  disp(precision);
##  disp(recall);
##  disp(fmeasure);  
endfunction

