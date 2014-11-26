function [strout] = tnm034(img)

close all;

img = img(:,:,1);

bwPic = im2bw(img);
bwPic = double(bwPic);
bwPic = preThresholding(bwPic);

figure;
imshow(bwPic);
hold on;
pause;

[coordsX, coordsY] = detectFiducial(bwPic);
[centroidMatrix] = findPoints(bwPic, coordsX, coordsY);
[newPic, pointNW] = transformPicture(centroidMatrix, img);


newBwPic = im2bw(newPic);
newBwPic = double(newBwPic);
newBwPic = medfilt2(newBwPic,[2 2]);
imshow(newBwPic);
pause;


[coordsX, coordsY] = detectFiducial(newBwPic);
[centroidMatrix] = findPoints(newBwPic, coordsX, coordsY);
boxSize = findBoxSize(centroidMatrix);
perfectPic = readImg(newBwPic, boxSize, centroidMatrix);
imgToChar(perfectPic);



