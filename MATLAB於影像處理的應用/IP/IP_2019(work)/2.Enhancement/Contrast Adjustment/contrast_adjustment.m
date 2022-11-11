%% Histogram example comparison
 clear all;close all;clc

I = imread('022.jpg');
%I = imread('cameraman.tif');
I=rgb2gray(I);

figure
subplot(5,5,1), imshow(I)
title('Original')

h1 = imhist(I);
axis1 = subplot(5,5,[2 5]);
bar(h1);
axis1.XLim = [0 256];
title('Original')
% change to double to make the repesenting range wider


%% imadjust - values in Low_High specify the bottom 1% and the top 1% of all pixel values

A = imadjust(I,stretchlim(I,0.01),[]);

subplot(5,5,6), imshow(A)
title('imadjust')

h3 = imhist(A);
axis3 = subplot(5,5,[7 10]);
bar(h3)
axis3.XLim = [0 256];
title('imadjust')

%%  Histogram equalization

[eq_im, T] = histeq(I);

subplot(5,5,11), imshow(eq_im)
title('histeq')

h4 = imhist(eq_im);
axis4 = subplot(5,5,[12 15]); 
bar(h4)
axis4.XLim = [0 256];
title('histeq')

%% Contrast-limited adaptive histogram equalization 
% operates on small regions in the image, called tiles, rather than the entire image
adpt = adapthisteq(I);

subplot(5,5,16), imshow(adpt)
title('adapthisteq')

h5 = imhist(adpt);
axis5 = subplot(5,5,[17 20]);
bar(h5)
axis5.XLim = [0 256];
title('adapthisteq')

%% Adjust histogram of image to match histogram of reference image

% use the result of CHAHE to adjust the result of HE
rematch = imhistmatch(eq_im, adpt);

subplot(5,5,21), imshow(rematch)
title('imhistmatch')

h5 = imhist(rematch);
axis5 = subplot(5,5,[22 25]);
bar(h5)
axis5.XLim = [0 256];
title('imhistmatch')
