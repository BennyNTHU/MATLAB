%% Load the image
clc;close all;clear;imtool close all;

worms = imread('wormsBW1.png');

%% Skeletonize the worms such that the dead worms become lines
wormSkel = bwmorph(worms,'skel',Inf);
figure, imshow(wormSkel)
title('Worms Skeleton')

%% Fit lines to the worms to extact their length using hough Transform
% Get the Hough Transform Matrix for the skeletonized worms
[H, T, R] = hough(wormSkel);

% Visualize the Hough Matrix
houghMatViz(H,T,R)

%% Locate peaks in the Hough transform matrix. Select a greater nHoodSize
% value to avois detecting lines that are very close by (similar rho and
% theta)
peaks = houghpeaks(H, 30,'NHoodSize', [55 11]);

%% Extract lines location corresponding to the peaks in Hough Transform matrix
lines = houghlines(wormSkel, T, R, peaks);

%% Visualize worms
figure
imshow(worms)
hold on

numLines = length(lines);

for k = 1:numLines
   xy = [lines(k).point1; lines(k).point2];
   
   % Plot the detected lines and highlight the beginnings and ends of lines
   % with green markers
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red',...
         'Marker', 'x', 'MarkerEdgeColor', 'g');

end

title('Detected lines plotted over worms image');
