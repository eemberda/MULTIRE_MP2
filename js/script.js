var imageDataArray=[];
var framesRGBA=[];
var framesRGB=[];
var bins=[];
var SD=[];//Frame Differences

var mean=0;
var alpha=0;
var standard_deviation=0;
var Tb=0;
var camera_breaks=[];
var camera_break_ts=[];
var frame_count=0;

var normalized_histogram=[];
var normalized_histogram_key_frames=[];

function toDataURL(url, callback){
    var xhr = new XMLHttpRequest();
    xhr.open('get', url);
    xhr.responseType = 'blob';
    xhr.onload = function(){
      var fr = new FileReader();
    
      fr.onload = function(){
        callback(this.result);
      };
    
      fr.readAsDataURL(xhr.response); // async call
    };
    
    xhr.send();
}

//**********************************************
//Event handler for loading image database
//**********************************************
function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object
    var list = document.getElementById('list');
    list.innerHTML="";
    framesRGBA=[];
    var counter=0;
    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {
      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }
      var reader = new FileReader();
      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
            var span = document.createElement('span');
            counter++;
            frame_count++;
            span.style="float:left;";
            span.innerHTML = ['Frame ',escape(counter),'<br><img id="', escape(theFile.name),'" class="thumb" src="', e.target.result,
                            '" title="', escape(theFile.name), '"/><br><br>'].join('');
            document.getElementById('list').insertBefore(span, null);

            var theImage = document.getElementById(escape(theFile.name));
            toDataURL(theImage.src, function(dataURL){
                // console.log(dataURL);

                // now just to show that passing to a canvas doesn't hold the same results
                var canvas = document.createElement('canvas');
                canvas.width = theImage.naturalWidth;
                canvas.height = theImage.naturalHeight;
                var context = canvas.getContext('2d');
                context.drawImage(theImage, 0,0);

                // console.log(canvas.toDataURL() === dataURL); // false - not same data

                var imgData = context.getImageData(0,0,theImage.naturalWidth, theImage.naturalHeight);
                imageDataArray.push(imgData);
                // CreateBins(imgData.data);
                // createRGB(imgData);
                // framesRGBA.push(imgData);
                // console.log(imgData);
            });   


        };
      })(f);

      // Read in the image file as a data URL.
      reader.readAsDataURL(f);

    }

}
function CreateBins(arr) {
    var tempBin=[];
    var prev=null;
    var colors;
    arr.sort(); //sort in ascending order
    // arr.reverse(); //reverse the order
    var j=0;
    for(var i=0;i<arr.length;i++){
        if ( arr[i] !== prev ) {
            j=arr[i];
            tempBin[j]=1;
            
        } else {
            tempBin[prev]++;
        }
        prev = arr[i];
    }
    


    // arr.sort();
    // console.log(arr);
    // console.log(tempBin);
    // for ( var i = 0; i < arr.length; i++ ) {
    //     if ( arr[i] !== prev ) {
    //         tempBin.push(arr[i]);
    //         tempBin[arr[i]].push(1);
    //     } else {
    //         tempBin[arr[i]][prev]++;
    //     }
    //     prev = arr[i];
    // }
    bins.push(tempBin);
}

function ComputeNormalizedHistogram(){
  var temp_norm_histogram=[];
  normalized_histogram=[];
  // for(var i=0;i<bins.length;i++){
  //   var size=bins[i].length;
  //   for(var j=0;j<size;j++){
  //     temp_norm_histogram.push([bins[i][j],(bins[i][j]/size)]);
  //   }
  //   normalized_histogram.push(temp_norm_histogram);
  // }
  var span = document.createElement('span');
  var html ="Key Frames:<br>";
  for(var i=0;i<camera_breaks.length;i++){
    if(i==0){
      frame_start=0;
      frame_end=camera_breaks[i][0];
    }
    else if(i==camera_breaks.length-1){
      frame_start=camera_breaks[i][0];
      frame_end=frame_count-1;
    }
    else{
      frame_start=camera_breaks[i-1][0]+1;
      frame_end=camera_breaks[i][0];
    }

    //compute for normalized histogram per shot
    var total_frequency=0;
    var average_frequency_pixels=0
    var temp_key_frame;
    for(var j=frame_start;j<=frame_end;j++){
      var diff=(imageDataArray[j].width * imageDataArray[j].height);
        var size=bins[j].length;
        var total_pixels = (imageDataArray[j].width * imageDataArray[j].height);
        var temp_norm_histogram2 = 0;
        for(var y=0;y<size;y++){
          temp_norm_histogram[y]=(bins[j][y]/total_pixels);
          temp_norm_histogram2+=(bins[j][y]/total_pixels);
          total_frequency+=bins[j][y];
        }
        temp_norm_histogram2 = temp_norm_histogram2/size;
        average_frequency_pixels = total_frequency/256;
        normalized_histogram[j]=temp_norm_histogram;
        var temp_diff=Math.abs(average_frequency_pixels-temp_norm_histogram2);
        if(temp_diff<diff){
          temp_key_frame = j+1;
          diff=temp_diff;
        }
    }
    normalized_histogram_key_frames.push(temp_key_frame);
    html+=temp_key_frame+"<br>";

  }  
  span.innerHTML = html;
  document.getElementById('video-segment').appendChild(span);
}

function ChooseKeyFrameNormalizedHistogram(){
  var frame_start;
  var frame_end;

  for(var i=0;i<camera_breaks.length;i++){
    if(i==0){
      frame_start=0;
      frame_end=camera_breaks[i][0];
    }
    else if(i==camera_breaks.length-1){
      frame_start=camera_breaks[i][0];
      frame_end=frame_count-1;
    }
    else{
      frame_start=camera_breaks[i-1][0]+1;
      frame_end=camera_breaks[i][0];
    }

    for(var j=frame_start;j<=frame_end;j++){

    }
  }
}

function createRGB(imgData){
    var xCoord = 0;
    var yCoord = 0;
    var canvasWidth = imgData.width * imgData.height;
    for(var i=0;i<imgData.width;i++)
      for(var j=0;j<imgData.height;j++){
        var colorIndices = getColorIndicesForCoord(i, j, imgData.width);
        // console.log("colorIndices: "+colorIndices);
        var redIndex = colorIndices[0];
        var greenIndex = colorIndices[1];
        var blueIndex = colorIndices[2];
        var alphaIndex = colorIndices[3];    
        var redForCoord = imgData.data[redIndex];
        var greenForCoord = imgData.data[greenIndex];
        var blueForCoord = imgData.data[blueIndex];
        var alphaForCoord = imgData.data[alphaIndex];    

        // console.log("red:"+redForCoord);
        // console.log("green:"+greenForCoord);
        // console.log("blue:"+blueForCoord);

        framesRGB.push([redForCoord,greenForCoord,blueForCoord]);
    }
    console.log("done");

}

function getColorIndicesForCoord(x, y, width) {
  var red = y * (width * 4) + x * 4;
  return [red, red + 1, red + 2, red + 3];
}

function ComputeFrameToFrameDifferences(){
  // imageDataArray.shift();
  bins=[];
  document.getElementById('video-segment').innerHTML="";
  for(var i=0;i<imageDataArray.length;i++){
    CreateBins(imageDataArray[i].data);
  }
  
  SD=[];
  // bins.shift();
  if(bins.length<=1){
    alert("Please load more than 1 frame");
    return;
  }
  for(var i=1;i<bins.length;i++){
    var sum=0;
    for(var j=0;j<bins[i].length-1;j++){
      // console.log("i="+i+" , j="+j + " bin1: "+bins[i][j] + " | bin2:" +bins[i-1][j]);
      if(bins[i][j]!=null && bins[i-1][j]!=null)
        sum+=Math.abs(bins[i][j]-bins[i-1][j]);

    }
    SD.push(sum);
  }

  //display the SD
  var span = document.createElement('span');
  var htmlText = "<ul>";

  for(var i=0;i<SD.length;i++){
    htmlText = htmlText + "<li>SD " + (i+1) + ": "+SD[i]+"</li>";
  }
  span.innerHTML = htmlText + "</ul>";
  document.getElementById('video-segment').insertBefore(span, null);


}

function ComputeTb(){
  //compute for the average of SD
  var sum=0;
  // var mean=0;
  for(var i=0;i<SD.length-1;i++){
    sum+=SD[i];
  }
  mean=sum/SD.length;


  //compute for standard deviation
  sum=0;
  for(var i=0;i<SD.length-1;i++){
    sum+=Math.pow((SD[i]-mean),2);
  }
  standard_deviation = Math.sqrt(sum/SD.length);
  alpha=parseInt(document.getElementById("txt-alpha").value);
  Tb=mean+(alpha*standard_deviation);

  var span = document.createElement('span');
  span.innerHTML ="µ: "+mean+"<br>" + "σ: "+standard_deviation+"<br>"+"Tb: "+Tb+"<br>";
  document.getElementById('video-segment').appendChild(span);

}

function MarkCameraBreaks(){
  camera_breaks=[];

  //display the camera breaks
  var span = document.createElement('span');
  var htmlText = "Camera Breaks:<br><ul>";

  for(var i=0;i<SD.length;i++){
    if(SD[i]>Tb){
      camera_breaks.push([i,SD[i]]);
      htmlText = htmlText + "<li>SD: " + (i+1) + ": "+SD[i]+"</li>";
    }
  }
  span.innerHTML = htmlText + "</ul>";
  document.getElementById('video-segment').appendChild(span);

}

function ComputeTs(){
  //compute for the average of SD
  var sum=0;
  var frame_start;
  var frame_end;
  var shot_length=0;
  var temp_mean=0;
  var temp_standard_deviation=0;
  var Ts=0;
  var span = document.createElement('span');
  var html_content="<br><h3>Grandual Transition Computation</h3><br>";
  var AC=0;
  var GT_potential=[];

  // var mean=0;
  for(var i=0;i<camera_breaks.length;i++){
    if(i==0){
      frame_start=0;
      frame_end=camera_breaks[i][0];
    }
    else if(i==camera_breaks.length-1){
      frame_start=camera_breaks[i][0];
      frame_end=frame_count-1;
    }
    else{
      frame_start=camera_breaks[i-1][0]+1;
      frame_end=camera_breaks[i][0];
    }

    sum=0;
    shot_length=(frame_end-frame_start);
    for(var j=0;j<shot_length;j++){
      sum+=SD[frame_start+j];
    }
    temp_mean=sum/shot_length;

    sum=0;
    for(var j=0;j<shot_length;j++){
      sum+=Math.pow((SD[frame_start+j]-temp_mean),2);
    }

    temp_standard_deviation = Math.sqrt(sum/shot_length);
    alpha=parseInt(document.getElementById("txt-alpha").value);
    Ts=temp_mean+(alpha*temp_standard_deviation);
    
    camera_break_ts.push([temp_mean,temp_standard_deviation,Ts]);//push mean, standard deviation, and Ts
    html_content+="<br>Camera Break # "+(i+1)+"<br>";
    html_content+="µ: "+temp_mean+"<br>" + "σ: "+temp_standard_deviation+"<br>"+"Ts: "+Ts+"<br>";
    span.innerHTML = html_content;
    document.getElementById('video-segment').appendChild(span);

    //compute for potential gradual transition
    var accumulator=0;
    var is_potential=false;
    html_content="";
    span = document.createElement('span');
    for(var frame=frame_start;frame<frame_end;frame++){
      if(SD[frame]>Ts){
        is_potential=true;
        GT_potential.push([frame,frame+1]);
        html_content+="Start Frame: "+(frame_start+1)+", End Frame: "+(frame_end+1)+"<br>";

      }
      accumulator+=SD[frame];
    }

    if(is_potential){
      GT_potential.push([frame_start,frame_end]);
      if(accumulator>Tb)
        html_content+="<br><strong>Gradual Transition Detected</strong><br>";
    }

    document.getElementById('video-segment').appendChild(span);

  }
}
      