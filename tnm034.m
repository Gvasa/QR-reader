function [strout] = tnm034(img)


%   binary1 = flipud(img([9:16] ,1)).';
% %   binary2 = flipud(img([17:24] ,1)).';
%   binary3 = flipud(img([25:32] ,1)).';
%   
%   binary4 = fliplr([0 1 1 0 0 1 1 1]);

binMat = zeros(183, 8);

RowCounter = 1;
ColCounter = 1;

for col = 1 : 41
   for row = 1 : 41
        if(checkIfValid(row, col) == 1)
            binMat(RowCounter, ColCounter) = img(row, col);
            
            if(ColCounter == 8)
                RowCounter = RowCounter+1;
                ColCounter = 1;
            else
                ColCounter = ColCounter+1;
            end
        end
   end
end
RowCounter
assignin('base', 'binMat', binMat);
for i = 1:183
    char(bi2de(fliplr(binMat(i, :))))
end



% char(bi2de(binary1))
% char(bi2de(binary2))
% char(bi2de(binary3))
% char(bi2de(binary4))


% 
% for i = 9:33
%     sout(1, i-8) = img(i);
% end


%bi2de(sout)

%img = imresize(img, [41 41]);


