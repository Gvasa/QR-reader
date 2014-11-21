function [strout] = tnm034(img)

close all;

bwPic = im2bw(img);
bwPic = double(bwPic);

c = corner(bwPic, 1000);
imshow(bwPic);
hold on;
plot(c(:,1), c(:,2), 'b*');

pause;

[coordsX, coordsY] = detectFiducial(bwPic);
[centroidMatrix, minmaxMatrix, fidNWwidth, fidNEwidth, distanceBetweenFid] = findPoints(bwPic, coordsX, coordsY);
[newPic, pointNW, boxSize] = transformPicture(centroidMatrix, minmaxMatrix, img);
boxSize = 14.5;

newBwPic = im2bw(newPic);
newBwPic = double(newBwPic);

%[coordsX, coordsY] = detectFiducial(newBwPic);
%[centroidMatrix, minmaxMatrix, fidNWwidth, fidNEwidth, distanceBetweenFid] = findPoints(newBwPic, coordsX, coordsY);
%boxSize = findBoxSize(fidNWwidth, fidNEwidth, distanceBetweenFid)
perfectPic = readImg(newPic, boxSize, pointNW);
imgToChar(perfectPic);
% 
startPosX = pointNW(1)-boxSize*3;
startPosY = pointNW(2)-boxSize*3;

% figure;
% imshow(preThresholding(newPic));
% hold on
% for col = 1 : 41
%    for row = 1 : 41
%        startX = startPosX+floor((row-1)*boxSize);
%        startY = startPosY+floor((col-1)*boxSize);
%        slutX = startPosX+floor((row)*boxSize);
%        slutY = startPosY+floor((col)*boxSize);
%        
%        plot([startX, slutX, slutX, startX, startX],[startY, startY, slutY, slutY, startY],'c','LineWidth',1);
%        hold on;
%    end 
% end




