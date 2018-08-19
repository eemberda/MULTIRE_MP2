function output = variable(queryImage,dbpath)
  
    disp("##############################");
  disp("DB Path in ch.m");
  disp("##############################");
  disp(dbpath);  
  
  ## Color Histogram Method
  level = 8;    % also referred to num of bins (mp1 rqmt 159)
  threshold = 0.5;
##  nfiles = ch_compute_normalized_histograms(dbpath, level, threshold);
  imagefiles = dir(strcat(dbpath,'*.jpg'));
  nfiles = length(imagefiles);

  load("normHists.mat");

  Q_normHist = ch_normalized_histograms(
                      imread(queryImage), 
                      level, 
                      threshold);
                      load("normHists.mat");
  SIM_QI = ch_compute_similarity_matrix(Q_normHist, normHists, nfiles)';
  disp(SIM_QI);


  db = {};
  keySet = {};
  for i=1:nfiles
    currentfilename = imagefiles(i).name;  
    keySet{i} = SIM_QI(i,1);
    valueSet{i} = currentfilename;
  end
  M = containers.Map(keySet,valueSet);

  filter_result = nfiles;
  k = keys(M) ;
  val = values(M) ;
  j = 1;
  qc = 0;
  m = 1;
##  disp("########################");
  for i=filter_result:-1:1
    CH{1,j} = val{i};
    CH{2,j} = k{i};
    if m == 1
      ## Ground Truth Indexing
      str = strsplit(val{i},".");
      c = str2num(str{1});
      qc = c;
      m = m + 1;
    end
    CH{3,j} = gt(qc,val{i});

##    disp(val{i});
##    disp(k{i});
    j = j + 1;
  end
##  disp("########################");
  output = CH;
end
    