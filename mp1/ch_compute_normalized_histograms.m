function output = variable(dbpath, level, threshold)

    disp("##############################");
  disp("DB Path in ch_normalized_histograms.m");
  disp("##############################");
  disp(dbpath);  
  
  imagefiles = dir(strcat(dbpath,'*.jpg'));
  nfiles = length(imagefiles);
  if not(exist("normHists.mat", "file") == 2)
    normHists = [];
    for i=1:nfiles
      currentfilename = imagefiles(i).name;
      normHists = [ normHists ch_normalized_histograms(
                        imread(strcat(dbpath,currentfilename)), 
                        level, 
                        threshold)];
    end
    save("normHists.mat","normHists");    
  end  
  output = nfiles;
end