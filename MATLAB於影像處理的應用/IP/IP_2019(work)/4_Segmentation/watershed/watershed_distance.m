%% Watershed transform using distance transform

close all;clear all;clc

img = imread('candy.jpg');
figure,subplot(3,3,1),imshow(img),title('original')

%% some preprocessing to improve the result of the watershed transform

% convert to binary
imgBW = img < 50;
subplot(3,3,2), imshow(imgBW), title('binary')

%% calculate the distance transform
% distance between that pixel and the nearest nonzero pixel of BW

[D,~] = bwdist(imgBW);
subplot(3,3,3), imshow(D,[]), title('distance')

%% use negative of D because objects must be minima

DN = -D;
subplot(3,3,4), imshow(DN,[]),title('-D')

%% set the background to -inf to improve results

DN(imgBW) = -inf;
subplot(3,3,5), imshow(DN,[]),title('-inf')

%% calculate watershed

L = watershed(DN);
subplot(3,3,6), imshow(L,[]), title('labelmatrix');

%% assign colors to result

ws = label2rgb(L,'jet','w');
subplot(3,3,7), imshow(ws), title('label2rgb');

%% turn the background into black and display result 

result = ws;
index = repmat(imgBW,[1,1,3]);
result(index)= 0;
subplot(3,3,8), imshow(result), title('watershed segmentation');
