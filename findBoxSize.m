function[boxSize] = findBoxSize(fidNWwidth, fidNEwidth, distanceBetweenFid)

boxSize1 = distanceBetweenFid/34
boxSize2 = fidNWwidth/6.5
boxSize3 = fidNEwidth/6.5

boxSize = (boxSize1 + boxSize2 + boxSize3)/3;