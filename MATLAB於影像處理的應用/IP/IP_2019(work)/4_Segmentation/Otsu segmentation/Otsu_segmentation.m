%% Using the logical-based segmentation
close all;clear all;clc

I = imread('cameraman.tif');

% find out a approximate threshold 
 imtool(I);

I_logical = I;
I_logical = (I_logical<70);

%% Using Otsu's method to find threshold for segmentation

thresh = graythresh(I);

I_otsu = im2bw(I,thresh);
I_otsu = ~I_otsu;

%% Show result

imshowpair(I_logical, I_otsu, 'montage');
title('Logical way(Left), Otsu''s method(Right)')

%% batch processing the segmentation task

close all;clear all;clc
imageBatchProcessor
