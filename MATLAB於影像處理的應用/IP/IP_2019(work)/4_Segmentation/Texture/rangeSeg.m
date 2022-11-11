%% Identify cells in an image based on texture
% Images from Alan W. Partin, M.D., Ph.D., Johns Hopkins University School of Medicine 

%% Read and display the image data
clc;close all;clear;imtool close all;

cells = imread('textureCell.tif');
figInput = figure;
imshow(cells)
title('Original')

%% Perform texture based filtering using the range filter.
rangeOutput = rangefilt(cells);
figure
imshow(rangeOutput,[])
title('Range filtered output')

%% Threshold the cells from the background of the image.
rangeBW = rangeOutput > 20;
figure
imshow(rangeBW);
title('Thresholded version of the image')

%% Fill the holes
rangeBW = imfill(rangeBW,'holes');
figure
imshow(rangeBW)
title('Thresholded version with the holes filled')

%% Remove smaller objects from the image to help identifying the cells.
% There are additional particles in the image that should not be identified
% as cells and the plan is to remove those smaller particles.
rangeBWopen = bwareaopen(rangeBW, 200);
figure
imshow(rangeBWopen);
title('Removed smaller objects from the image');

%% Display the original image and plot the object boundaries on it
figure(figInput)
hold on
visboundaries(rangeBWopen);
title('\bfCells segmented on the basis of Range');
