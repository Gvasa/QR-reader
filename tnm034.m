function [strout] = tnm034(img)

close all;

% Threshhold the picture
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
centroidMatrix = [centroidMatrix; findAlignP(centroidMatrix, bwPic)];
[newPic, pointNW] = transformPicture(centroidMatrix, img);

% Filt and threshhold
newBwPic = medfilt2(newPic);
newBwPic = preThresholding(newBwPic);
imshow(newBwPic);

% Dectect, Find points, findBoxSize and read
[coordsX, coordsY] = detectFiducial(newBwPic);
[centroidMatrix] = findPoints(newBwPic, coordsX, coordsY);
boxSize = findBoxSize(centroidMatrix);
perfectPic = readImg(newBwPic, boxSize, centroidMatrix);
strout = (imgToChar(perfectPic))
char(strout)



