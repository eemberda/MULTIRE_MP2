function search(object_handle, event,
                database_path_handle, query_path_handle,
                method_choice_handle, 
                imgs_1_handle, imgs_2_handle, imgs_3_handle, imgs_4_handle, imgs_5_handle,
                imgs_6_handle, imgs_7_handle, imgs_8_handle, imgs_9_handle, imgs_10_handle,
                imgs_11_handle, imgs_12_handle, imgs_13_handle, imgs_14_handle, imgs_15_handle,                
                imgR_1_label_handle, imgR_2_label_handle, imgR_3_label_handle, imgR_4_label_handle, imgR_5_label_handle,
                imgR_6_label_handle, imgR_7_label_handle, imgR_8_label_handle, imgR_9_label_handle, imgR_10_label_handle,
                imgR_11_label_handle, imgR_12_label_handle, imgR_13_label_handle, imgR_14_label_handle, imgR_15_label_handle,
                precision_handle,recall_handle,fmeasure_handle)
  dbpath = get(database_path_handle,'string');
##  disp(strcat('dbpath: ',dbpath));
##  disp("########################"); 
  querypath = get(query_path_handle,'string');
##  disp(strcat('querypath:',querypath));
##  disp("########################"); 
  method = get (method_choice_handle, "string"){get (method_choice_handle, "value")};
  if strcmp(method,"Color Histogram (CH)")==1
##      disp("1");
      color_histogram = ch(querypath,dbpath);   
    
      disp("########################");
      disp("Color Histogram");  
      disp("########################"); 
      disp(color_histogram);
      
      ground_truth_positive = [.4 0.6 0.5];
      ground_truth_negative = [1 0.4 0.4];
      
      file1 = char(color_histogram(1,1));
      file1 = strcat(dbpath,file1);
      imgR1 = imread(file1);
      axes(imgs_1_handle(1,1));
      imshow(imgR1,[]);
      similarity1 = color_histogram(2,1);
      sim1 = similarity1{1};
      set(imgR_1_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,1)));
      set(imgR_1_label_handle,'string',num2str(sim1));
      
      file2 = char(color_histogram(1,2));
      file2 = strcat(dbpath,file2);
      imgR2 = imread(file2);
      axes(imgs_2_handle(1,1));
      imshow(imgR2,[]);    
      similarity2 = color_histogram(2,2);
      set(imgR_2_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,2)));
      set(imgR_2_label_handle,'string',num2str(similarity2{1}));
      
      file3 = char(color_histogram(1,3));
      file3 = strcat(dbpath,file3);
      imgR3 = imread(file3);
      axes(imgs_3_handle(1,1));
      imshow(imgR3,[]);
      similarity3 = color_histogram(2,3);
      set(imgR_3_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,3)));
      set(imgR_3_label_handle,'string',num2str(similarity3{1}));
      
      file4 = char(color_histogram(1,4));
      file4 = strcat(dbpath,file4);
      imgR4 = imread(file4);
      axes(imgs_4_handle(1,1));
      imshow(imgR4,[]); 
      similarity4 = color_histogram(2,4);
      set(imgR_4_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,4)));
      set(imgR_4_label_handle,'string',num2str(similarity4{1}));    
            
      file5 = char(color_histogram(1,5));
      file5 = strcat(dbpath,file5);
      imgR5 = imread(file5);
      axes(imgs_5_handle(1,1));
      imshow(imgR5,[]);
      similarity5 = color_histogram(2,5);
      set(imgR_5_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,5)));
      set(imgR_5_label_handle,'string',num2str(similarity5{1}));   
            
      file6 = char(color_histogram(1,6));
      file6 = strcat(dbpath,file6);
      imgR6 = imread(file6);
      axes(imgs_6_handle(1,1));
      imshow(imgR6,[]);
      similarity6 = color_histogram(2,6);
      set(imgR_6_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,6)));
      set(imgR_6_label_handle,'string',num2str(similarity6{1}));  
  
      file7 = char(color_histogram(1,7));
      file7 = strcat(dbpath,file7);
      imgR7 = imread(file7);
      axes(imgs_7_handle(1,1));
      imshow(imgR7,[]);
      similarity7 = color_histogram(2,7);
      set(imgR_7_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,7)));
      set(imgR_7_label_handle,'string',num2str(similarity7{1}));   
 
      file8 = char(color_histogram(1,8));
      file8 = strcat(dbpath,file8);
      imgR8 = imread(file8);
      axes(imgs_8_handle(1,1));
      imshow(imgR8,[]);
      similarity8 = color_histogram(2,8);
      set(imgR_8_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,8)));
      set(imgR_8_label_handle,'string',num2str(similarity8{1}));
     
      file9 = char(color_histogram(1,9));
      file9 = strcat(dbpath,file9);
      imgR9 = imread(file9);
      axes(imgs_9_handle(1,1));
      imshow(imgR9,[]);
      similarity9 = color_histogram(2,9);
      set(imgR_9_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,9)));
      set(imgR_9_label_handle,'string',num2str(similarity9{1}));  
      
      file10 = char(color_histogram(1,10));
      file10 = strcat(dbpath,file10);
      imgR10 = imread(file10);
      axes(imgs_10_handle(1,1));
      imshow(imgR10,[]);
      similarity10 = color_histogram(2,10);
      set(imgR_10_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,10)));
      set(imgR_10_label_handle,'string',num2str(similarity10{1})); 
      
      file11 = char(color_histogram(1,11));
      file11 = strcat(dbpath,file11);
      imgR11 = imread(file11);
      axes(imgs_11_handle(1,1));
      imshow(imgR11,[]);
      similarity11 = color_histogram(2,11);
      set(imgR_11_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,11)));
      set(imgR_11_label_handle,'string',num2str(similarity11{1})); 
      
      file12 = char(color_histogram(1,12));
      file12 = strcat(dbpath,file12);
      imgR12 = imread(file12);
      axes(imgs_12_handle(1,1));
      imshow(imgR12,[]);
      similarity12 = color_histogram(2,12);
      set(imgR_12_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,12)));
      set(imgR_12_label_handle,'string',num2str(similarity12{1})); 
       
      file13 = char(color_histogram(1,13));
      file13 = strcat(dbpath,file13);
      imgR13 = imread(file13);
      axes(imgs_13_handle(1,1));
      imshow(imgR13,[]);
      similarity13 = color_histogram(2,13);
      set(imgR_13_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,13)));
      set(imgR_13_label_handle,'string',num2str(similarity13{1})); 
      
      file14 = char(color_histogram(1,14));
      file14 = strcat(dbpath,file14);
      imgR14 = imread(file14);
      axes(imgs_14_handle(1,1));
      imshow(imgR14,[]);
      similarity14 = color_histogram(2,14);
      set(imgR_14_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,14)));
      set(imgR_14_label_handle,'string',num2str(similarity14{1}));      
            
      file15 = char(color_histogram(1,15));
      file15 = strcat(dbpath,file15);
      imgR15 = imread(file15);
      axes(imgs_15_handle(1,1));
      imshow(imgR15,[]);
      similarity15 = color_histogram(2,15);
      set(imgR_15_label_handle,"backgroundcolor",gt_get_color(color_histogram(3,15)));
      set(imgR_15_label_handle,'string',num2str(similarity15{1}));    
    
      rank_max = 15;
      thres = 0.5;
      save("ch.mat","color_histogram");  
      ch_compute_performance(rank_max,thres,precision_handle,recall_handle,fmeasure_handle);
      
  elseif strcmp(method,"CH with Perceptual Similarity")==1
    disp("2");
    msgbox("Nothing here yet!");
  elseif strcmp(method,"HistRefine with Color Coherence")==1
    disp("3");
  else
    disp("4");
  end
##  disp(strcat('method:',method));
endfunction

