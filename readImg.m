function[perfectPic] = readImg(img, boxSize, centroidMatrix)

startPosX = floor((centroidMatrix(1,1))-(boxSize/2)*7);
startPosY = floor((centroidMatrix(1,2))-(boxSize/2)*7);

for col = 1 : 41
   for row = 1 : 41
       startX = startPosX+floor((row-1)*boxSize);
       startY = startPosY+floor((col-1)*boxSize);
       slutX = startPosX+floor((row)*boxSize);
       slutY = startPosY+floor((col)*boxSize);
    
       med = mean(mean(img(startY:slutY, startX:slutX)));
       pixel = med > 0.5;
       perfectPic(col,row) = pixel;
   end 
end