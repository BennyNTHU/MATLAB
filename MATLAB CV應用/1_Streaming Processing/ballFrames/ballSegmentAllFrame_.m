%% Read video frames from the ball.avi file.

videoFReader = vision.VideoFileReader('..\ball.avi','VideoOutputDataType','double');
%% Play the video file using the video player
%  Retrieve the screen size in pixels
videoPlayer=resizePlayer;

%% Apply the yellow ball segmentation algorithm to all video frames
while ~isDone(videoFReader)
    
    frame = videoFReader();
    
    % Convert to HSV and apply threshold to hue plane
    Ihsv = rgb2hsv(frame);
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
    
    %% Higlight the detected object
 
    % Create a AlphaBlender object to highlight the detected object in the
    % original video frame.
    alphaBlending = vision.AlphaBlender;
    alphaBlending.Operation = 'Highlight selected pixels';
    
    frame = alphaBlending(frame, mask);
    
    % Insert a text of number of objects detected and mark the location of the object
    % Insert a string of number of objects detected in the video frame.
    numObj = length(props.MajorAxisLength);
    str = [num2str(numObj),' object(s) detected'];
    frame = insertText(frame,[20 20], str, 'textColor',[1 1 0],...
        'FontSize',18);
    
    % Draw a circle around the detected objects
    frame = insertShape(frame, 'Circle', ...
        [props.Centroid,props.MajorAxisLength/2]) ;
    
    
    videoPlayer(frame);
end

%% Release objects
release(videoPlayer)
release(videoFReader)

