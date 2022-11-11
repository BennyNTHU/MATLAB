%% Segment rice from nonuniform backgroud
close all;clear all;clc

I = imread('rice.png');
imshow(I)

%% detect the edge using sobel method

[sobeledge, th] = edge(I, 'sobel');
figure, imshow(sobeledge)

%% correct the threshold

sobeledge_mod = edge(I, 'sobel', 0.07);
imshow(sobeledge_mod)

%% fill the hole 

grain = imfill(sobeledge_mod, 'holes');
figure, imshow(grain)

%% using morphological operation bwmorph to close the leak  


gapClosed = bwmorph(sobeledge_mod,'bridge');

figure, imshow(gapClosed)

%% 
% --------------------------------------------------------
% So it is the wrong way to do such segmentation, 
% try another approach.
% --------------------------------------------------------

%% try segment out the rice by otsu's method directly
close all; clear all;clc
imtool close all;

I = imread('rice.png');

level = graythresh(I);
bw = im2bw(I,level);
figure, imshowpair(I,bw,'montage')


%%  Estimate the Background
% use |imopen| to estimate the background illumination.

background = imopen(I, strel('disk',15));
figure, subplot(2,1,1), imshow(background);
h2 = imhist(background);
subplot(2,1,2), bar(h2);


% Notice that the background illumination is brighter in the center of the
% image than at the bottom. 
figure, surf(double(background(1:10:end,1:10:end))),zlim([0 255]);
set(gca,'ydir','reverse');

%% Subtract the Background Image from the Original Image

I2 = I - background;
figure, subplot(2,1,1), imshow(I2);
h3 = imhist(I2);
subplot(2,1,2), bar(h3);

%% using |imtophat| 
% calculates the morphological opening and then
% subtracts it from the original image.

 I22 = imtophat(I, strel('disk',15));
 figure, imshow(I22)

%% increase the Image Contrast

I3 = imadjust(I22);
figure, imshow(I3);

%% create a binary image by thresholding the adjusted image

level = graythresh(I3);
bw = im2bw(I3,level);
figure, imshow(bw)

%% remove background noise with |bwareaopen|

bw_remove_noise = bwareaopen(bw, 50);
figure, imshow(bw_remove_noise)

%% remove the partial rice which is on the border

bw_remove_borderones = imclearborder(bw_remove_noise);
figure, imshow(bw_remove_borderones)


%% identify Objects in the Image

cc = bwconncomp(bw_remove_borderones, 4);
labeled = labelmatrix(cc);

%% find the smallest rice grain

graindata = regionprops(labeled);
grain_areas = [graindata.Area];
[min_area, idx] = min(grain_areas);

% creat a bw to show the minimal grain of rice
grain2 = false(size(bw));
grain2(cc.PixelIdxList{idx}) = true;
figure, imshow(grain2);

%% using APP for analyzing the properties of segmented result 

imageRegionAnalyzer(bw_remove_borderones)
