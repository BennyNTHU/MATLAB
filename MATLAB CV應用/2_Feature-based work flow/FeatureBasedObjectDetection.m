%% Object Detection In A Cluttered Scene Using SURF
% Read the reference image containing the object of interest.
close all;clear;clc
boxImage = imread('stapleRemover.jpg'); % 要尋找的目標

figure; imshow(boxImage);
title('Image of a Box');

% Read the target image containing a cluttered scene.
sceneImage = imread('clutteredDesk.jpg'); % 在這張圖中尋找boxImage所包含的目標
figure; imshow(sceneImage);
title('Image of a Cluttered Scene');

%% Detect Feature Points
% Detect feature points in both images.
boxPoints = detectSURFFeatures(boxImage);
scenePoints = detectSURFFeatures(sceneImage);

%% Visualize the strongest feature points found in the reference image.
figure; imshow(boxImage);
title('50 Strongest Feature Points from Box Image');
hold on;
plot(boxPoints.selectStrongest(50));

% Visualize the strongest feature points found in the target image.
figure; imshow(sceneImage);
title('200 Strongest Feature Points from Scene Image');
hold on;
plot(scenePoints.selectStrongest(200));

%% Extract Feature Descriptors
% Extract feature descriptors at the interest points in both images.
[boxFeatures, validboxPoints] = extractFeatures(boxImage, boxPoints);
[sceneFeatures, validscenePoints] = extractFeatures(sceneImage, scenePoints);

%% Find Putative Point Matches
% Match the features using their descriptors. 
boxPairs = matchFeatures(boxFeatures, sceneFeatures);

% Display putatively matched features.  
matchedBoxPoints = validboxPoints(boxPairs(:, 1), :);
matchedScenePoints = validscenePoints(boxPairs(:, 2), :);

figure;
showMatchedFeatures(boxImage, sceneImage, matchedBoxPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');

%% Locate the Object in the Scene Using Putative Matches

% |estimateGeometricTransform| calculates the transformation relating the
% matched points, while eliminating outliers using MSAC algorithm.
[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

% Display the matching point pairs with the outliers removed
figure;
showMatchedFeatures(boxImage, sceneImage, inlierBoxPoints, inlierScenePoints, 'montage');
title('Matched Points (Inliers Only)');

%%  Get the bounding polygon of the reference image.
boxPolygon = [1, 1;...                           % top-left
        size(boxImage, 2), 1;...                 % top-right
        size(boxImage, 2), size(boxImage, 1);... % bottom-right
        1, size(boxImage, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon

%% Transform the polygon into the coordinate system of the target image.

newBoxPolygon = transformPointsForward(tform, boxPolygon);    

%%
% Display the detected object.
figure; imshow(sceneImage);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Box');
