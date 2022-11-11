%% Detect up right people
% Read input image
I = imread('visionteam1.jpg');

% Create a Pedestrial Detector: Hg features and SVM classifier
pedestrianDetector = vision.PeopleDetector;
[bbox,score]= pedestrianDetector(I);

detectedImg = insertObjectAnnotation(I, 'rectangle', bbox, score);

figure,
imshow(detectedImg);
title('Detected Pedestrians');