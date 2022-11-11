%% Color Image Contrast Enhancement 
close all;clear all;clc
% read in an indexed RGB image: |autumn.tif|.

scene = imread('lanyu.jpg');
%scene = imread('Beijing.jpg');
%scene = imread('lanyu.jpg');
figure,
imshow(scene)

%% Color space comversion
% Manipulating luminosity affects the intensity of the pixels, while preserving the original colors.

% color space converter
srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');

shadow_lab = applycform(scene, srgb2lab); 

% the values of luminosity can span a range from 0 to 100
% normalize the value from 0 to 1 for better calcualation result
%max_luminosity = 100;
L = shadow_lab(:,:,1);

%% Contrast enhancement
% replace the luminosity layer with the processed data and then convert
% the image back to the RGB colorspace

% strech histogram distrution method
shadow_imadjust = shadow_lab;
shadow_imadjust(:,:,1) = imadjust(L);
shadow_imadjust = applycform(shadow_imadjust, lab2srgb);

% histogram equalization method
shadow_histeq = shadow_lab;
shadow_histeq(:,:,1) = histeq(L);
shadow_histeq = applycform(shadow_histeq, lab2srgb);

% adaptive histogram equalization method
shadow_adapthisteq = shadow_lab;
shadow_adapthisteq(:,:,1) = adapthisteq(L);
shadow_adapthisteq = applycform(shadow_adapthisteq, lab2srgb);


figure, 
subplot(2,2,1), imshow(scene);
title('Original');
subplot(2,2,2), imshow(shadow_imadjust);
title('Imadjust');
subplot(2,2,3), imshow(shadow_histeq);
title('Histeq');
subplot(2,2,4), imshow(shadow_adapthisteq);
title('Adapthisteq');
