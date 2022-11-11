%% Read video frames from the ball.avi file.
clc;clear;close all;

videoFReader = vision.VideoFileReader('ball.avi');

%% Play the video file using the video player
videoPlayer = vision.VideoPlayer;

%%
n=0; % 計算有多少Frame
while ~isDone(videoFReader)
  videoFrame = videoFReader();
  videoPlayer(videoFrame);
  pause(0.1)
  n=n+1
end

%%
% Close the video player object
release(videoPlayer);

% Reset the videoFReader to the beginning of the file
reset(videoFReader)

%% Get the 15th frames of the video
n = 0;
while n~=15
  videoFrame = videoFReader();
  n = n+1;
end
figure
imshow(videoFrame)
title('15th frame')

%% Release objects
release(videoFReader)