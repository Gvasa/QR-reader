function[perfectPic] = readImg(img, boxSize, pointNW)


newImg = preThresholding(img);

perfectPic = zeros(41);
imshow(newImg);
hold on;

startPosX = floor(pointNW(1)-boxSize*3);
startPosY = floor(pointNW(2)-boxSize*3);

for col = 1 : 41
   for row = 1 : 41
       startX = startPosX+floor((row-1)*boxSize);
       startY = startPosY+floor((col-1)*boxSize);
       slutX = startPosX+floor((row)*boxSize);
       slutY = startPosY+floor((col)*boxSize);
       plot([startX, slutX, slutX, startX, startX],[startY, startY, slutY, slutY, startY],'c','LineWidth',1);
    
       med = mean(mean(newImg(startY:slutY, startX:slutX)));
       pixel = med > 0.6;
       perfectPic(col,row) = pixel;
       hold on;
   end 
end

figure;
imshow(perfectPic);