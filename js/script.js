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
            span.innerHTML = ['<img id="', escape(theFile.name),'" class="thumb" src="', e.target.result,
                            '" title="', escape(theFile.name), '"/>'].join('');
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
  for(var i=0;i<SD.length-1;i++){
    if(SD[i]>Tb){
      camera_breaks.push([i,SD[i]]);
    }
  }
}

function ComputeTs(){
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
      