function [strout] = tnm034(img)

detectFiducial(img);

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
RowCounter-1;
assignin('base', 'binMat', binMat);

charMat = zeros(1, RowCounter);


for i = 1:183
    charMat(1,i) = char(bi2de(fliplr(binMat(i, :))));
end

char(charMat)



