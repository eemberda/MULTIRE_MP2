function output = variable(Q_normHist, normHists, nfiles)
  [N,~] = size(normHists);
  SIM_QI = [];
  for i=1:nfiles
      sum = 0;
      for j=1:N
        NHQ = Q_normHist(j,1);
        NHI = normHists(j,i);
        if NHQ == 0  && NHI == 0
          expr = 1;
        else
          expr = 1 - (abs(NHQ-NHI)/max(NHQ,NHI));
        end      
        sum = sum + expr;
      end
      SIM_QI = [SIM_QI (sum / N)]
   end   
  output = SIM_QI;
end

