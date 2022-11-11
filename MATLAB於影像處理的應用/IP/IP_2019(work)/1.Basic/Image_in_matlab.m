%% Color image
close all;clear all;clc

rbg = imread('lenna.bmp');
figure,imshow(rbg);
%% Gray scale image

gray = imread('cameraman.tif');
figure,imshow(gray);
%% Binary image

binary = imread('shapes.bmp');
figure,imshow(binary);

%% Color to Grayscale image

color2gray = rgb2gray(rbg);
figure,imshow(color2gray);

%% Grayscale to Binary image

thresh = graythresh(gray);
% Use that threshold to create a binary image.
binarization = imbinarize(gray, thresh);
figure,imshow(binarization);
%% Grayscale to Binary image-2
BW1 = gray>50;
BW2 = gray>200;

figure
subplot(1,2,1), imshow(BW1);
title('I > 50')
subplot(1,2,2), imshow(BW2);
title('I > 200')

%% imtool demonstration

imtool(rbg)
imtool(gray)