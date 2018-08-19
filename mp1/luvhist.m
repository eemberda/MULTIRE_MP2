function luvColorHistogram = luvhist( im )
% This function computes the image color histogram in L*, u*, v* color
% space.

[rows, cols, numOfBands] = size(im);
% totalPixelsOfImage = rows*cols*numOfBands;

% convert rgb to L* u* v* color space
im = rgb2luv(im);

% split image into L*, u* & v* planes
L = im(:, :, 1);
u = im(:, :, 2);
v = im(:, :, 3);

% quantize each h,s,v equivalently to 8x2x2
% Specify the number of quantization levels.
% thresholdForL = multithresh(L, 7);  % 7 thresholds result in 8 image levels
% thresholdForU = multithresh(u, 1);  % Computing one threshold will quantize ...
%                                     % the image into three discrete levels
% thresholdForV = multithresh(v, 1);  % 7 thresholds result in 8 image levels
% 
% seg_l = imquantize(L, thresholdForL); % apply the thresholds to obtain segmented image
% seg_u = imquantize(u, thresholdForU); % apply the thresholds to obtain segmented image
% seg_v = imquantize(v, thresholdForV); % apply the thresholds to obtain segmented image

% quantize each L*, u* & v* to 8x2x2
numberOfLevelsForL = 8;
numberOfLevelsForU = 2;
numberOfLevelsForV = 2;

% Find the max.
maxValueForL = max(L(:));
maxValueForU = max(u(:));
maxValueForV = max(v(:));

% create final histogram matrix of size 8x2x2
luvColorHistogram = zeros(numberOfLevelsForL, numberOfLevelsForU, numberOfLevelsForV);

% create col vector of indexes for later reference
index = zeros(rows*cols, numOfBands);

% Put all pixels into one of the "numberOfLevels" levels.
count = 1;
quantizedValueForL = zeros(size(L, 1),size(L, 2));
quantizedValueForU = zeros(size(L, 1),size(L, 2));
quantizedValueForV = zeros(size(L, 1),size(L, 2));
for row = 1:size(L, 1)
    for col = 1 : size(L, 2)
        quantizedValueForL(row, col) = ceil(numberOfLevelsForL * L(row, col)/maxValueForL);
        quantizedValueForU(row, col) = ceil(numberOfLevelsForU * u(row, col)/maxValueForU);
        quantizedValueForV(row, col) = ceil(numberOfLevelsForV * v(row, col)/maxValueForV);
        
        % keep indexes where 1 should be put in matrix luvHist
        index(count, 1) = quantizedValueForL(row, col);
        index(count, 2) = quantizedValueForU(row, col);
        index(count, 3) = quantizedValueForV(row, col);
        count = count+1;
    end
end

% put each value of l,u,v to matrix 8x2x2
% (e.g. if l=7,u=2,v=1 then put 1 to matrix 8x2x2 in position 7,2,1)
for row = 1:size(index, 1)
    if (index(row, 1) == 0 || index(row, 2) == 0 || index(row, 3) == 0)
        continue;
    end
    luvColorHistogram(index(row, 1), index(row, 2), index(row, 3)) = ... 
        luvColorHistogram(index(row, 1), index(row, 2), index(row, 3)) + 1;
end

% normalize luvHist to unit sum
luvColorHistogram = luvColorHistogram(:)';
luvColorHistogram = luvColorHistogram/sum(luvColorHistogram);

% clear workspace
% clear('row', 'col', 'count', 'numberOfLevelsForL', 'numberOfLevelsForL', ...
%     'numberOfLevelsForV', 'maxValueForL', 'maxValueForU', 'maxValueForV', ...
%     'index', 'rows', 'cols', 'L', 'u', 'v', 'image', 'quantizedValueForL', ...
%     'quantizedValueForU', 'quantizedValueForV');

% figure('Name', 'Quantized leves for L, U & V');
% subplot(2, 3, 1);
% imshow(seg_l, []);
% subplot(2, 3, 2);
% imshow(seg_u, []);
% title('Quantized L,U & V by matlab function imquantize');
% subplot(2, 3, 3);
% imshow(seg_v, []);
% subplot(2, 3, 4);
% imshow(quantizedValueForL, []);
% subplot(2, 3, 5);
% imshow(quantizedValueForU, []);
% title('Quantized L,U & V by my function');
% subplot(2, 3, 6);
% imshow(quantizedValueForV, []);

end

