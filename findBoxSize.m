function[boxSize] = findBoxSize(centroidMatrix)% Punkterna

% Punkterna
pointNW = [centroidMatrix(1,1) centroidMatrix(1,2)];
pointNE = [centroidMatrix(2,1) centroidMatrix(2,2)];
pointSW = [centroidMatrix(3,1) centroidMatrix(3,2)];

% Ta ut l?ngden mellan de olika fid
NWtoNE = (norm(pointNW - pointNE));
NWtoSW = (norm(pointNW - pointSW));

% R?kna ut pixelstorleken
boxSize = min([NWtoNE NWtoSW]) / 34;