%% Segment rice from nonuniform backgroud
clc;close all;clear;

I = imread('rice.png');
figure, imshow(I)

%% Try to segment out the rice by otsu's method directly
bw = imbinarize(I,graythresh(I));
figure, imshowpair(I,bw,'montage')

%% Detect the edge using sobel method
sobeledge_mod = edge(I, 'sobel', 0.07);
imshow(sobeledge_mod)

%% Fill the hole 
grain = imfill(sobeledge_mod, 'holes');
imshow(grain)

%% 
% --------------------------------------------------------
% So it is the wrong way to do such segmentation, 
% try another approach.
% --------------------------------------------------------

%%  Estimate the background
% use morphlogical operation to estimate the background illumination.
SE=strel('disk',15);

background = imerode(I, SE);
background = imdilate(background, SE);

figure, subplot(2,1,1), imshow(background);
h2 = imhist(background);
subplot(2,1,2), bar(h2);

%% Subtract the background from the original image
I2 = I - background;

figure, subplot(2,1,1), imshow(I2);
h3 = imhist(I2);
subplot(2,1,2), bar(h3);

%% Adjust image contrast
I3 = imadjust(I2);
figure, imshow(I3);

%% Create a binary image by thresholding the adjusted image
bw = imbinarize(I3,graythresh(I3));
figure, imshow(bw)

%% Remove background noise with |bwareaopen|
bw_remove_noise = bwareaopen(bw, 50);
figure, imshow(bw_remove_noise)

%% Remove the partial grain which is on the border
bw_remove_borderones = imclearborder(bw_remove_noise);
figure, imshow(bw_remove_borderones)

%% Identify objects in the Image
CC = bwconncomp(bw_remove_borderones, 4);
CC.NumObjects

%% Create a label matrix and observe the label values for each object.
L = labelmatrix(CC);
% Create an RGB image from the label matrix to visualize every object
% with different colors.
RGB = label2rgb(L);
figure, imshow(RGB)

%% Find the smallest rice grain
graindata = regionprops(L);

%%
grain_areas = [graindata.Area];
[min_area, idx] = min(grain_areas);

% creat a bw to show the minimal grain of rice
grain2 = false(size(bw));
grain2(CC.PixelIdxList{idx}) = true;
figure, imshow(grain2);

%% using APP for analyzing the properties of segmented result 

imageRegionAnalyzer(bw_remove_borderones)
