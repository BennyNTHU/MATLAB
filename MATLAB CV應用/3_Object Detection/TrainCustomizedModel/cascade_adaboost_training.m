%% Train a cascade object detector for stop signs
clc;clear;close all;
stopSignPath=fullfile(matlabroot,'toolbox','vision','visiondata','stopSignImages');
nostopSignPath=fullfile(matlabroot,'toolbox','vision','visiondata','nonStopSigns');

% browse stop sign images
imageBrowser(stopSignPath)

%% Label positive samples
trainingImageLabeler(stopSignPath)

%% Load the positive samples data
load('stopSigns.mat');

% Add the images location to the MATLAB path.
addpath(stopSignPath);

%% Train a cascade object detector called 'stopSignDetector.xml' using HOG feature
num=1;
switch num
    case 1
        trainCascadeObjectDetector('stopSignDetector.xml', data, nostopSignPath, ...
            'FalseAlarmRate', 0.1, 'NumCascadeStages', 4, 'FeatureType', 'HOG');
    case 2
        trainCascadeObjectDetector('stopSignDetector.xml', data, nostopSignPath, ...
            'FalseAlarmRate', 0.001, 'NumCascadeStages', 4, 'FeatureType', 'LBP');
end

%% Use the newly trained classifier to detect on a test image
I = imread('pedestrian.jpg');

stopSignDetector = vision.CascadeObjectDetector('stopSignDetector.xml');
bbox = stopSignDetector(I);

detectedImg = insertObjectAnnotation(I, 'rectangle', bbox, 'Stop Sign','FontSize',20);
detectedImg = insertShape(detectedImg, 'FilledRectangle',bbox,'Opacity',0.6,'LineWidth',5);

figure
imshow(detectedImg);
title('Stop sign detection');

%% test capability of detector
stopSignDetector = vision.CascadeObjectDetector('stopSignDetector.xml');

videoFileStopSign = vision.VideoFileReader('vipwarnsigns.avi');
videoPlayer = vision.VideoPlayer('Name', 'Stop Sign Detector');

while ~isDone(videoFileStopSign)
    frame = videoFileStopSign();
    bbox = stopSignDetector(frame);
    Img = insertObjectAnnotation(frame,'rectangle',bbox,'stop sign');
    videoPlayer(Img);  
end
%%
release(stopSignDetector);
release(videoFileStopSign);
release(videoPlayer);

% Remove the image directory from the path.
rmpath(stopSignPath);