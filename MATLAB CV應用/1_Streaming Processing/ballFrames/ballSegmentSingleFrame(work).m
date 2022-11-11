%% Develop the algorithm working on a single frame
clc;clear;close all;

%% Load single frame
load ('ballFrames.mat','frame')
figure, imshow(frame)
title('Original')

%% Use Function


%% Segment yellow areas of image in HSV color space
% 1. Convert from RGB to HSV colorspace
% 2. Extract hue plane
% 3. Apply a threshold

Ihsv = rgb2hsv(frame);
hue = Ihsv(:,:,1);
figure, imshow(hue)
% Yellow

% Red


figure, imshow(BW)
title('Thresholding')

%% Morphological
% Use morphological operations to remove disturbances
SE = strel('disk', 7);

BW_open = imopen(BW,SE);
BW_close = imclose(BW,SE);
BW_dilate = imdilate(BW,SE);
BW_erode = imerode(BW,SE);

figure, imshow(BW_open)
title('imopen')
figure, imshow(BW_close)
title('imclose')
figure, imshow(BW_dilate)
title('imdilate')
figure, imshow(BW_erode)
title('imerode')

% Exclude any objects which have less than 5000 pixel area.
BW = bwareaopen(BW,5000); 
figure, imshow(BW)

% Exclude the objects that are touching the border.
mask = imclearborder(BW);

% show image
figure, imshow(mask)
title('Ball only') 

%% Regionprops
% Get shape properties of all object which have more than 5000 pixels.
props = regionprops('table',mask,'Centroid','MajorAxisLength');

%% Higlight the detected object
% Create a AlphaBlender object to highlight the detected object in the
% original video frame.
alphaBlending = vision.AlphaBlender;
alphaBlending.Operation = 'Highlight selected pixels';

frame = alphaBlending(frame, mask);
figure, imshow(frame)
title('Object highlighted')

%% Insert a text of number of objects detected and mark the location of the object
% Insert a string of number of objects detected in the video frame.
numObj = length(props.MajorAxisLength);
str = [num2str(numObj),' object(s) detected'];

frame2 = insertText(frame,[20 20], str, 'textColor',[1 1 0], 'FontSize',28);

% Draw a circle around the detected objects
frame2 = insertShape(frame2, 'Circle', ...
    [props.Centroid,props.MajorAxisLength/2],'LineWidth',5) ;
imshow(frame2)
