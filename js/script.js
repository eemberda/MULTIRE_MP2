var framesRGBA=[];
var framesRGB=[];
var bins=[[]];
var SD=[];//Frame Differences


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
                console.log(dataURL);

                // now just to show that passing to a canvas doesn't hold the same results
                var canvas = document.createElement('canvas');
                canvas.width = theImage.naturalWidth;
                canvas.height = theImage.naturalHeight;
                var context = canvas.getContext('2d');
                context.drawImage(theImage, 0,0);

                // console.log(canvas.toDataURL() === dataURL); // false - not same data

                var imgData = context.getImageData(0,0,theImage.naturalWidth, theImage.naturalHeight);
                createRGB(imgData);
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
    arr.sort();
    for ( var i = 0; i < arr.length; i++ ) {
        if ( arr[i] !== prev ) {
            temp.push(arr[i]);
            bins[arr[i]].push(1);
        } else {
            bins[arr[i]][prev]++;
        }
        prev = arr[i];
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
  for(var i=0;i<framesRGB.length;i++){
    bins=CreateBins(framesRGB[i]);
  }
}
      