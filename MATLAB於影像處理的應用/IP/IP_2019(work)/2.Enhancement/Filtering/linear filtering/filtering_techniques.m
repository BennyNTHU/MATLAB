%% Input test pattern
close all;clear all;clc

im = imread('cameraman.tif');
figure
imshow(im)
title('Test image')

%% Apply a lowpass filter with zero-padding acroos the border

b = fir1(30,0.3);
h = ftrans2(b);
figure, subplot(1,3,1)
freqz2(h)
axis equal

g1 = imfilter(im, h);
subplot(1,3,2), imshow(g1)
axis off
title('lowpass filter(zero padding)')

%% Apply a lowpass filter with mirror-reflecting acroos the border

g1s = imfilter(im, h, 'symmetric');
subplot(1,3,3), imshow(g1s)
axis off
title('lowpass filter(symmetric padding)')

%% Apply a highpass filter
 
b2 = fir1(30, 0.3, 'high');
h2 = ftrans2(b2);
figure, subplot(1,2,1)
freqz2(h2)
axis equal

g2 = imfilter(im, h2, 'symmetric');
subplot(1,2,2), imshow(g2, [])
axis off
title('highpass filter')

%% Apply a bandpass filter

b3 = fir1(30, [0.3 0.4]);
h3 = ftrans2(b3);
figure, subplot(1,2,1)
freqz2(h3)
axis equal

g3 = imfilter(im, h3);
subplot(1,2,2), imshow(g3, [])
title('bandpass filter')

%% Apply an average filter

avg_filter =  fspecial('average', 9);
figure, subplot(1,2,1)
freqz2(avg_filter)
axis equal

g4 = imfilter(im, avg_filter, 'symmetric');
subplot(1,2,2), imshow(g4)
title('9-by-9 averaging filter')

%% Apply a gaussian lowpass filter with imfilter

glp_filter = fspecial('gaussian', 9, 2);
g5 = imfilter(im, glp_filter, 'symmetric');

figure, subplot(1,2,1)
freqz2(glp_filter)
axis equal

subplot(1,2,2), imshow(g5)
title('9-by-9 Gaussian filter')

%% Usinge adaptive wiener filter

wiener_filtered = wiener2(im,[9 9]);

figure,
imshow(wiener_filtered)
title('Using wiener filter')

%% Usinge guided filter (keep structuring information)

edge_preserved = imguidedfilter(im, 'DegreeOfSmoothing', 0.03*diff(getrangefromclass(im)).^2);

figure,
imshow(edge_preserved)
title('Using guided filter')
