function output = variable(image, level, threshold)
  ## 1.0 CIE Conversion
  Ilab = rgb2lab(image);

  ## 2.0 Linearly re-quantize N or levels = 8  2^8 = 256 color features
  ## To remove unnecessary colors to the image
  Ilab = imresize(Ilab, [level, level]); % imresize uses bicubic interpolation
  [Mr,Nr,~] = size(Ilab);    
  colorFeatures = reshape(Ilab, Mr*Nr, []);

  ## 3.0 Normalize Histogram
  rowNorm = sqrt(sum(colorFeatures.^2,2));
  colorFeatures = bsxfun(@rdivide, colorFeatures, rowNorm + eps);
  
  ## 4.0 Set threshold = 0.5 for *L*a*b Color Feature
  ## x = [-0.5	-0.35714	-0.21429	-0.071429	0.071429	0.21429	0.35714	0.5]
  ## x = [-0.5	-0.35714	-0.21429	-0.071429	0.071429	0.21429	0.35714	0.5]
  
  xnorm = linspace(-threshold, threshold, Nr);      
  ynorm = linspace(-threshold, threshold, Mr);    
  [x, y] = meshgrid(xnorm, ynorm);  
  
  ##  5.0 Color Variance Metric
  features = [colorFeatures y(:) x(:)];
  metrics  = var(colorFeatures(:,1:3),0,2);
  
  output = metrics;
end
