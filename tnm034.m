function [strout] = tnm034(img)

close all;

bwPic = im2bw(img);
bwPic = double(bwPic);
imshow(bwPic);
pause;

[coordsX, coordsY] = detectFiducial(bwPic);
[centroidMatrix, minmaxMatrix, fidNWwidth, fidNEwidth, distanceBetweenFid] = findPoints(bwPic, coordsX, coordsY);
[newPic, pointNW] = transformPicture(centroidMatrix, minmaxMatrix, img);


newBwPic = im2bw(newPic);
newBwPic = double(newBwPic);

[coordsX, coordsY] = detectFiducial(newBwPic);
[centroidMatrix, minmaxMatrix, fidNWwidth, fidNEwidth, distanceBetweenFid] = findPoints(newBwPic, coordsX, coordsY);
boxSize = findBoxSize(fidNWwidth, fidNEwidth, distanceBetweenFid);

binMat = zeros(183, 8);
RowCounter = 1;
ColCounter = 1;

startPosX = pointNW(1)-boxSize*3.5;
startPosY = pointNW(2)-boxSize*3.5;

hold on

for col = 1 : 41
   for row = 1 : 41
       startX = startPosX+floor((row-1)*boxSize);
       startY = startPosY+floor((col-1)*boxSize);
       slutX = startPosX+floor((row)*boxSize);
       slutY = startPosY+floor((col)*boxSize);
       
       plot([startX, slutX, slutX, startX, startX],[startY, startY, slutY, slutY, startY],'c','LineWidth',1);
       hold on;
   end 
end
            
            %binMat(RowCounter, ColCounter) = (mean(mean(cropedImg(floor(col*pixelSize):floor((col+1)*pixelSize),floor(row*pixelSize):floor((row+1)*pixelSize)))) > 0.5);
            
%             if(ColCounter == 8)
%                 RowCounter = RowCounter+1;
%                 ColCounter = 1;
%             else
%                 ColCounter = ColCounter+1;
%             end

% RowCounter-1;
% assignin('base', 'binMat', binMat);
% 
% charMat = zeros(1, RowCounter);
% 
% 
% for i = 1:183
%     charMat(1,i) = char(bi2de(fliplr(binMat(i, :))));
% end
% 
% char(charMat)



