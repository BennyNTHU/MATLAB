%% Import and display the image.
clc;close all;clear;

worms = imread('worms.tif');
figure, imshow(worms,[]);

%% Detect worm edges with default Sobel method.
wormsEdge = edge(worms);
figure,imshow(wormsEdge);

%% Get the default threshold value.
[wormsEdge,thresh] = edge(worms);
thresh

%% Increase the threshold value to reduce background noise detection.
wormsEdge = edge(worms, 0.004);
imshow(wormsEdge);

%===============================================%
%% Detect worm edges using the Canny operator and observe thethreshold.
[wormsEdge,thresh] = edge(worms,'canny');
imshow(wormsEdge);
thresh

%% Increase the threshold value to ignore noise detection.
% edge uses this value for the high value and uses threshold*0.4 for the low threshold.
wormsEdge = edge(worms,'canny', 0.25);
imshow(wormsEdge);

%===============================================%
%% Preprocess and segment out the worms to create a binary image.
wormsBW = createBinaryWorms(worms);
figure, imshow(wormsBW);

%% Extract edges from the binary worms¡¦ image.
wormsEdge = edge(wormsBW,'canny');
imshow(wormsEdge)

%============================================%
%% Extract the boundaries of all the worms
wormsBoundary = bwboundaries(wormsBW);
numBoundaries = length(wormsBoundary)

%% Display the original image and plot the object boundaries on it
figure, imshow(worms,[])
hold on
% Highlight the bounderies using a thin line.
visboundaries(wormsBoundary,'LineWidth',1,'EnhanceVisibility',false)
