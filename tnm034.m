function [strout] = tnm034(img)

close all;

% Reduce noice and Illum-problems
img = IllumFix(img);

% Threshhold the picture
bwPic = preThresholding(img);

%Detect, Find Points, Rotate
[coordsX, coordsY] = detectFiducial(bwPic);
[centroidMatrix, antalgrannar] = findPoints(bwPic, coordsX, coordsY, 3);
while(any(centroidMatrix==0)) % If no points were found, increase number of neighbours
    [centroidMatrix, antalgrannar] = findPoints(bwPic, coordsX, coordsY, antalgrannar+1);
end
img = rotatePicture(centroidMatrix, img);

% Detect, Find Points, Crop
bwPic = preThresholding(img);
[coordsX, coordsY] = detectFiducial(bwPic);
[centroidMatrix, antalgrannar] = findPoints(bwPic, coordsX, coordsY, 3);
while(any(centroidMatrix==0)) % If no points were found, increase number of neighbours
    [centroidMatrix, antalgrannar] = findPoints(bwPic, coordsX, coordsY, antalgrannar+1);
end
boxSize = findBoxSize(centroidMatrix);
[img] = cropImg(centroidMatrix, img, boxSize);


% Detect, Find Points, Transform
bwPic = preThresholding(img);
[coordsX, coordsY] = detectFiducial(bwPic);
[centroidMatrix, antalgrannar] = findPoints(bwPic, coordsX, coordsY, 3);
while(any(centroidMatrix==0)) % If no points were found, increase number of neighbours
    [centroidMatrix, antalgrannar] = findPoints(bwPic, coordsX, coordsY, antalgrannar+1);
end
centroidMatrix = [centroidMatrix; findAlignP(centroidMatrix, bwPic)];
[newPic, pointNW] = transformPicture(centroidMatrix, img);

% Filter and threshhold the transform image
newBwPic = medfilt2(newPic);
newBwPic = preThresholding(newBwPic);

% Dectect, Find points, findBoxSize and read the qr code
[coordsX, coordsY] = detectFiducial(newBwPic);
[centroidMatrix, antalgrannar] = findPoints(newBwPic, coordsX, coordsY, 3);
while(any(centroidMatrix==0)) % If no points were found, increase number of neighbours
    [centroidMatrix, antalgrannar] = findPoints(newBwPic, coordsX, coordsY, antalgrannar+1);
end
boxSize = findBoxSize(centroidMatrix);
perfectPic = readImg(newBwPic, boxSize, centroidMatrix);
strout = (imgToChar(perfectPic));
char(strout);



