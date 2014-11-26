function[perfectPic] = readImg(img, boxSize, centroidMatrix)

perfectPic = zeros(41);
figure
imshow(img);
hold on;

startPosX = floor((centroidMatrix(1,1))-boxSize*3.5);
startPosY = floor((centroidMatrix(1,2))-boxSize*3.5);

for col = 1 : 41
   for row = 1 : 41
       startX = startPosX+floor((row-1)*boxSize);
       startY = startPosY+floor((col-1)*boxSize);
       slutX = startPosX+floor((row)*boxSize);
       slutY = startPosY+floor((col)*boxSize);
       plot([startX, slutX, slutX, startX, startX],[startY, startY, slutY, slutY, startY],'c','LineWidth',1);
    
       med = mean(mean(img(startY:slutY, startX:slutX)));
       pixel = med > 0.5;
       perfectPic(col,row) = pixel;
       hold on;
   end 
end

% figure;
% imshow(perfectPic);