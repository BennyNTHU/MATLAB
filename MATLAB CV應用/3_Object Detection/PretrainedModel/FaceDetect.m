%% Using Viola-Jones detection algorithm and a trained classification model
close all;clear;clc
% Create a cascade detector object for detecting different facial features
feature =1;

switch feature
    
    case 1 % frontal face (Default)
        detector = vision.CascadeObjectDetector();
    case 2 % a pair of eyes
        detector = vision.CascadeObjectDetector('EyePairSmall');
    case 3 % mouth
        detector = vision.CascadeObjectDetector('Mouth');
        %         if more than one facial feature is detected, increment the merge threshold
        detector.MergeThreshold=20;
        detector.MinSize=[50 90];
        
    otherwise
        warning('Feature is unassigned')
end

%% Use the detector
facialImg = imread('facialDetectionTest.bmp');
bbox = detector(facialImg)

%% Plot results
detectedImg = insertObjectAnnotation(facialImg,'rectangle',bbox,'Facial feature');

figure;
imshow(detectedImg);