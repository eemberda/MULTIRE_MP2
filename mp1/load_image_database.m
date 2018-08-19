function load_image_database(object_handle,event,
                              database_path_handle,
                              total_images_handle)
##  str = get(dbpath_handle,'string');  
##  disp(strcat("path: ",path));  
##  disp(strcat("string: ",str)); 
  path = uigetdir();
  set(database_path_handle,'string',path);
  
  imagefiles = dir(strcat(path,"*.jpg"));
  nfiles = length(imagefiles);
  set(total_images_handle,'string',num2str(nfiles));
  
  level = 8;    % also referred to num of bins (mp1 rqmt 159)
  threshold = 0.5;
  delete("normHists.mat");
  nfiles = ch_compute_normalized_histograms(path, level, threshold);
  
endfunction
