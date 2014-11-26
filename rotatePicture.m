function[newImg] = rotatePicture(centroidMatrix, img)

disp('Rotate');
pointNW = [centroidMatrix(1,1) centroidMatrix(1,2)];
pointNE = [centroidMatrix(2,1) centroidMatrix(2,2)];
pointXX = [centroidMatrix(2,1) centroidMatrix(1,2)];

plot(pointNW(1), pointNW(2), 'r*');
plot(pointNE(1), pointNE(2), 'r*');
plot(pointXX(1), pointXX(2), 'g*');


hyp = norm(pointNW-pointNE);
mot = norm(pointXX-pointNE);
near = norm(pointNW-pointXX);

radtodeg(asin(mot/hyp))

if(centroidMatrix(2,2) > centroidMatrix(1,2))
    newImg = imrotate(img,radtodeg(asin(mot/hyp)),'bicubic');
else
    newImg = imrotate(img,-radtodeg(asin(mot/hyp)),'bicubic');
end


