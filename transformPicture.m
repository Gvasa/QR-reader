function [newImg,pointNW] = transformPicture(centroidMatrix, minmaxMatrix, img)

pointNW = [centroidMatrix(1,1) centroidMatrix(1,2)];
pointNE = [centroidMatrix(2,1) centroidMatrix(2,2)];
pointSW = [centroidMatrix(3,1) centroidMatrix(3,2)];
pointSE = [centroidMatrix(4,1) centroidMatrix(4,2)];

wantedPointNW = pointNW;
wantedPointNE = [(round(norm(pointNE - pointNW)) + pointNW(1)), pointNW(2)];
wantedPointSW = [pointNW(1), (round(norm(pointSW - pointNW)) + pointNW(2))];

transformMatrix = [wantedPointNW 1; wantedPointNE 1; wantedPointSW 1];
centroidMatrixTemp = [centroidMatrix(1:3, :) ones(3,1)];

tM = transformMatrix\centroidMatrixTemp;

k = 1;
[imgX, imgY] = size(img);
m = zeros(imgX * imgY,2);

for i = 1:imgX
    for j = 1:imgY
        m(k,1) = i;
        m(k,2) = j;
        m(k,3) = 1;
        k = k+1;
    end
    k = k+1;
end


m1 = floor(m*tM);

newImg = zeros(imgX, imgY);
k = 1;

for i = 1:imgX
    for j = 1:imgY
        if(m1(k,1) > 0 && m1(k,1) < imgX && m1(k,2) > 0 && m1(k,2) < imgY)
            newImg(m1(k,1), m1(k,2)) = img(i,j);
        end
        k = k+1;
    end
    k = k+1;
end

newImg = newImg/255;
figure
imshow(newImg);
hold on;
plot([transformMatrix(:,1); transformMatrix(1,1)],[transformMatrix(:,2); transformMatrix(1,2)],'Color','c','LineWidth',1);
plot(transformMatrix(1,1), transformMatrix(1,2), 'c*');
plot(transformMatrix(2,1), transformMatrix(2,2), 'c*');
plot(transformMatrix(3,1), transformMatrix(3,2), 'c*');

plot([centroidMatrix(1:3,1); centroidMatrix(1,1)],[centroidMatrix(1:3,2); centroidMatrix(1,2)],'Color','g','LineWidth',1);
plot(centroidMatrix(1,1), centroidMatrix(1,2), 'g*');
plot(centroidMatrix(2,1), centroidMatrix(2,2), 'g*');
plot(centroidMatrix(3,1), centroidMatrix(3,2), 'g*');
plot(centroidMatrix(4,1), centroidMatrix(4,2), 'g*');

pause;
