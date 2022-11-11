% Goal: To identify cells in an image based on texture

%% Read and display the image data
clc;close all;clear;imtool close all;

cells = imread('textureCell.tif');
figInput = figure;
imshow(cells)
title('Original')

%% Perform texture based filtering using the standard deviation filter.
stdOutput = stdfilt(cells);
figure
imshow(stdOutput,[])
title('Standard deviation filtered output')

%% Threshold the cells from the background of the image.
stdBW = stdOutput > 7;
figure, imshow(stdBW);
title('Thresholded version of the image')
stdBW = imfill(stdBW,'holes');
figure
imshow(stdBW)
title('Thresholded version with the holes filled')

%% Remove smaller objects from the image to help identifying the cells.
% There are additional particles in the image that should not be identified
% as cells and the plan is to remove those smaller particles.
stdBWopen = bwareaopen(stdBW, 200);
figure
imshow(stdBWopen);
title('Removed smaller objects from the image');

%% Display the original image and plot the object boundaries on it
figure(figInput)
hold on
visboundaries(stdBWopen);
title('\bfCells segmented on the basis of Standard Deviation');
