function load_image_query(object_handle,event,ImgQuery_handle,query_path_handle,...
          imgs_1_handle, imgs_2_handle, imgs_3_handle, imgs_4_handle, imgs_5_handle,
          imgs_6_handle, imgs_7_handle, imgs_8_handle, imgs_9_handle, imgs_10_handle,
          imgs_11_handle, imgs_12_handle, imgs_13_handle, imgs_14_handle, imgs_15_handle,                
          imgR_1_label_handle, imgR_2_label_handle, imgR_3_label_handle, imgR_4_label_handle, imgR_5_label_handle,
          imgR_6_label_handle, imgR_7_label_handle, imgR_8_label_handle, imgR_9_label_handle, imgR_10_label_handle,
          imgR_11_label_handle, imgR_12_label_handle, imgR_13_label_handle, imgR_14_label_handle, imgR_15_label_handle,
          precision_handle,recall_handle,fmeasure_handle)
      
[fname,fpath,~] = uigetfile({"*.jpg", "Supported Picture Format"});
  file = strcat(fpath,fname);  
  set(query_path_handle,'string',file);
##  disp("##############################");
##  disp("File Info");
##  disp("##############################");
##  disp(fname);
##  disp(fpath);
  
  imgQ = imread(file);
  axes(ImgQuery_handle);
  imshow(imgQ,[]);

  imgR_0 = imread("0.png");
  axes(imgs_1_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_1_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_1_label_handle,'string',"");  

  axes(imgs_2_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_2_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_2_label_handle,'string',"");  

  axes(imgs_3_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_3_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_3_label_handle,'string',"");  
 
  axes(imgs_4_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_4_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_4_label_handle,'string',"");  
  
  axes(imgs_5_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_5_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_5_label_handle,'string',"");  
   
  axes(imgs_6_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_6_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_6_label_handle,'string',""); 
   
  axes(imgs_7_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_7_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_7_label_handle,'string',"");  
    
  axes(imgs_8_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_8_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_8_label_handle,'string',"");   
  
  axes(imgs_9_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_9_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_9_label_handle,'string',""); 
  
  axes(imgs_10_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_10_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_10_label_handle,'string',"");   
  
  axes(imgs_11_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_11_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_11_label_handle,'string',"");   
  
  axes(imgs_12_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_12_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_12_label_handle,'string',"");   
    
  axes(imgs_13_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_13_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_13_label_handle,'string',"");   
    
  axes(imgs_14_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_14_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_14_label_handle,'string',"");   
  
  axes(imgs_15_handle(1,1));
  imshow(imgR_0,[]);
  set(imgR_15_label_handle,"backgroundcolor",[0.85 0.85 0.85]);
  set(imgR_15_label_handle,'string',"");   
  
  set(precision_handle,'string',"0");  
  set(recall_handle,'string',"0");  
  set(fmeasure_handle,'string',"0");  
  
endfunction



