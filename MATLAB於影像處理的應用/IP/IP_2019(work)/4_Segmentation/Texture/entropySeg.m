% Goal: To identify cells in an image based on texture

%% Read and display the image data
clc;close all;clear;imtool close all;

cells = imread('textureCell.tif');
figInput = figure;
imshow(cells)
title('Original')

%% Perform texture based filtering using the entropy filter
entropyOutput = entropyfilt(cells);
figure
imshow(entropyOutput,[])
title('Entropy filtered output')

%% Threshold the cells from the background of the image
entropyBW = entropyOutput > 4.7;
figure, imshow(entropyBW);
title('Thresholded version of the image')
entropyFill = imfill(entropyBW,'holes');
figure
imshow(entropyFill);
title('Thresholded version with holes filled')

%% Remove smaller objects from the image to help identifying the cells.
% There are additional particles in the image that should not be identified
% as cells and the plan is to remove those smaller particles.
entropyBWopen = bwareaopen(entropyFill, 400);
figure
imshow(entropyBWopen);
title('Removed smaller objects from the image')

%% Display the original image and plot the object boundaries on it
figure(figInput)
hold on
visboundaries(entropyBWopen);
title('\bfCells segmented on the basis of Entropy');
