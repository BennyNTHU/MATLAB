%% Find the car Face in video stream using pattern matching
close all;clear;clc

% read the template image
car_template = imread('car_template.tif');
car_template = im2double(car_template);
imshow(car_template)

%% System Objects initialization

filename = 'shaky_car.avi';
% read video data from binary file as grayscale data type
hVideoSource = vision.VideoFileReader(filename, ...
                                      'ImageColorSpace', 'Intensity',...
                                      'VideoOutputDataType', 'double');

% locates a template in an image by calculating the SSD value
hTemplateMatcher = vision.TemplateMatcher;
hTemplateMatcher.BestMatchNeighborhoodOutputPort = 1;

%% Selection Algorithm

%hTemplateMatcher.Metric = 'Sum of squared differences';
%hTemplateMatcher.Metric = 'Sum of absolute differences';
hTemplateMatcher.Metric = 'Maximum absolute difference';

%% Draw

% draw rectangle on an image
hShapes = vision.ShapeInserter;
hShapes.Shape = 'Rectangles';
hShapes.BorderColor='White'; 

% initialize a video player
hvp = vision.VideoPlayer;

%% Pattern matching in stream processing 

% threshold as the low boundary of the correlation value
threshold = 100;

 while ~isDone(hVideoSource)
   % get one frame from file  
   I = step(hVideoSource);
 
   % calculate the differences
   [xyLocarion, calculatedResult, insideImage] = step(hTemplateMatcher, I, car_template);
       
   % draw a rectangle on image if the difference is smaller than setting
   % threshold and the template is total inside the reference image
   if (min(calculatedResult(:)) < threshold && insideImage == 1)
      rectPos = [xyLocarion(:,1)-size(car_template,1)/2 xyLocarion(:,2)-size(car_template,2)/2 size(car_template)];
      Imf = step(hShapes, I, rectPos);
   else
      Imf = I;
   end
   
   % show frame in a video player
   step(hvp,Imf);
 end
 