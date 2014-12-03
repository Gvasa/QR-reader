function[newImg] = IllumFix(img)
img = im2double(img);

% Check how many channels
% [x xChannels] = size(size(img));
% 
% 
% % if color - do rgb2gray
% if(xChannels >2)
%     img = rgb2gray(img);
% end

img = img(:,:,1);

% imshow(img);
% pause;


% Reduce noice
img = imguidedfilter(img);
[orginalSizeX orginalSizeY] = size(img); 

% Resize our filterImg - faster
checkImg = imresize(img, 0.1);

% Local max
fun = @(x) max(max(x));

% Make filter img with filtermatrix orginalsize devided by 20, and using
% function
checkImg = nlfilter(checkImg,[floor(orginalSizeX/20) floor(orginalSizeY/20)],fun);

% Resize filter img to orginalImg
checkImg = imresize(checkImg, [orginalSizeX orginalSizeY]);

% Devied our orignalImg by filter img
newImg = img./checkImg;

% Check values over 1 and below 0
newImg(newImg > 1) = 1;
newImg(newImg < 0) = 0;

% figure;
% imshow(newImg);
% pause;

end