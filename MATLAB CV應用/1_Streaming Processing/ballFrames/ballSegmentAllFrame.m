%% Read video frames from the ball.avi file.
clc;clear;close all;

videoFReader = vision.VideoFileReader('ball.avi',...
    'VideoOutputDataType','double');

%% Play the video file using the video player
%  Retrieve the screen size in pixels
r = groot;
scrPos = r.ScreenSize;
%  Size/position is always a 4-element vector: [x0 y0 dx dy]
dx = scrPos(3); dy = scrPos(4);

videoPlayer = vision.VideoPlayer('Position',[dx/8, dy/8, dx*(3/4), dy*(3/4)]);

%% Create a AlphaBlender object to highlight the detected object in the
% original video frame.
alphaBlender = vision.AlphaBlender;
alphaBlender.Operation = 'Highlight selected pixels';

%% Apply the yellow ball segmentation algorithm to all video frames
while ~isDone(videoFReader)
    
    videoFrame = videoFReader();

    % Convert to HSV, extract hue plane and extract yellowish objects.
    Ihsv = rgb2hsv(videoFrame);
    hue = Ihsv(:,:,1);
    BW = hue >= 0.1 & hue < 0.15;
    
    % Use morphological operations to remove disturbances
    SE = strel('disk', 7);
    BW = imopen(BW,SE);
    
     % Exclude any objects which have less than 5000 pixel area.
    BW = bwareaopen(BW,5000);
    
    % Exclude the objects that are touching the border.
    mask = imclearborder(BW);
    
    % Get shape properties of all object which have more than 5000 pixels.
    props = regionprops('table',mask,'Centroid','MajorAxisLength');
    
    % Highlight the detected ball
    videoFrame = alphaBlender(videoFrame, mask);
    
    % Insert a string of number of objects detected in the video frame.
    numObj = length(props.MajorAxisLength);
    str = [num2str(numObj),' object(s) detected'];
    videoFrame = insertText(videoFrame,[20 20], str,...
        'textColor',[1 1 0],'FontSize',28);
    
    % Draw a circle around the detected objects
    videoFrame = insertShape(videoFrame, 'Circle', ...
        [props.Centroid,props.MajorAxisLength/2],'LineWidth',5) ;
    
    videoPlayer(videoFrame);
end

%% Release objects
release(videoPlayer)
release(videoFReader)





