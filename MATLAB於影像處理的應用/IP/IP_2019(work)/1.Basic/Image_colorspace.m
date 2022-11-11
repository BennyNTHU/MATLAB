%% Get all three RGB channel images relatively
close all;clear all;clc

RGB = imread('lenna.bmp');
imshow(RGB);

% only get the intensity value of R channel
Red = RGB(:,:,1);
figure, imshow(Red);

% red channel
R(:,:,1) = RGB(:,:,1);
R(:,:,2) = 0;
R(:,:,3) = 0;
% green channel
G(:,:,2) = RGB(:,:,2);
G(:,:,1) = 0;
G(:,:,3) = 0;
% blue channel
B(:,:,3) = RGB(:,:,3);
B(:,:,1) = 0;
B(:,:,2) = 0;

figure,
subplot(2,2,1),imshow(RGB)
subplot(2,2,2),imshow(R)
subplot(2,2,3),imshow(G)
subplot(2,2,4),imshow(B)

%% Color space transformation
ColorPlane = reshape(ones(64,1)*reshape(jet(64),1,192),[64,64,3]);

HSV=rgb2hsv(RGB);

H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);
% 
BW = H >= 0.05 & H < 0.95;
figure
imshow(BW)

figure
subplot(2,2,1), imshow(ColorPlane), title('RGB')
subplot(2,2,2), imshow(H), title('Hue')
subplot(2,2,3), imshow(S), title('Saturation')
subplot(2,2,4), imshow(V), title('Value')
%% Indexed image
close all; 

[Iindexed, map]= rgb2ind(RGB,32);
figure
imshow(Iindexed, map)

%% Export image
imwrite(Iindexed, map,'IndexedLenna.png');

