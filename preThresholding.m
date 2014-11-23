function[newPic] = preThresholding(img)
close all;

% HItta max och min i bilden
maxPic = max(img(:));
minPic = min(img(:));

% Skapa en tr?skling med max och min
newPic = img > (maxPic+minPic)/2;

