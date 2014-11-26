function [strout] = tnm034(img)

close all;
% Threshholdning picture
img = img(:,:,1);
[sizeX, sizeY] = size(img);
bwPic = preThresholding(img);

% Detect, Find Points, Rotate
[coordsX, coordsY] = detectFiducial(bwPic);
[centroidMatrix] = findPoints(bwPic, coordsX, coordsY);
img = rotatePicture(centroidMatrix, img);

% Detect, Find Points, Transform
[sizeX, sizeY] = size(img);
bwPic = preThresholding(img);
[coordsX, coordsY] = detectFiducial(bwPic);
[centroidMatrix] = findPoints(bwPic, coordsX, coordsY);
[newPic, pointNW] = transformPicture(centroidMatrix, img);

% 
newBwPic = medfilt2(newPic);
newBwPic = preThresholding(newBwPic);

[coordsX, coordsY] = detectFiducial(newBwPic);
[centroidMatrix] = findPoints(newBwPic, coordsX, coordsY);
boxSize = findBoxSize(centroidMatrix);
perfectPic = readImg(newBwPic, boxSize, centroidMatrix);
imgToChar(perfectPic);



