clear; clc; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Last modified time : 2016/12/1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters
param.numberOfSamples           = 10;
param.matchingThreshold         = 20;
param.matchingNumber            = 2;
param.updateFactor              = 5;
param.numberOfHistoryImages     = 2;
param.lastHistoryImageSwapped   = 0;

%% Video Information
filename = 'runingman.avi';
vidObj = VideoReader(filename);

firstFrame = true;
height = vidObj.Height;
width = vidObj.Width;

param.height = height;
param.width = width;

%% ViBe Moving Object Detection
i=0;
while hasFrame(vidObj)
    i=i+1;
    vidFrame = readFrame(vidObj);
%     figure(1), imshow(vidFrame), title('Original Image');
    vidFrame = rgb2gray(vidFrame);
    vidFrame = double(vidFrame);

    tic;
    if firstFrame
        firstFrame = false;
        initViBe;
    end
    segmentationMap = vibeSegmentation(vidFrame, historyImages, historyBuffer, param);    
    [historyImages, historyBuffer] = vibeUpdate(vidFrame, segmentationMap, historyImages, historyBuffer, param, ...
        jump, neighborX, neighborY, position);
    segmentationMap = medfilt2(segmentationMap);
    toc;
    
    figure(2), imshow(segmentationMap), title('Segmentation');
    imwrite(segmentationMap,strcat('./background/',num2str(i,'%03d'),'.png'));
end