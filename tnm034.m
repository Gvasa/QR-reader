function [strout] = tnm034(img)

close all;

bwPic = im2bw(img);
bwPic = double(bwPic);
bwPic = preThresholding(bwPic);

imshow(bwPic);
pause;

[coordsX, coordsY] = detectFiducial(bwPic);
[centroidMatrix] = findPoints(bwPic, coordsX, coordsY);
[newPic, pointNW] = transformPicture(centroidMatrix, img);

newBwPic = im2bw(newPic);
newBwPic = double(newBwPic);

[coordsX, coordsY] = detectFiducial(newBwPic);
[centroidMatrix] = findPoints(newBwPic, coordsX, coordsY);
boxSize = findBoxSize(centroidMatrix);
perfectPic = readImg(newPic, boxSize, pointNW);
imgToChar(perfectPic);



