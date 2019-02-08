function bw2surf(bwArray)

[nRows, nCols, nLayers] = size(bwArray);

%%  Generate x and y matricies
xData = 1:nRows;
for i = 1:nCols
    xData2(:,i) = xData;
end

xData = xData2;
yData = xData';

%   Preallocate maxZ and minZ
maxZ = nan(nRows, nCols);
minZ = maxZ;

%%  Map minimum and maximum layer indexes to zData matrix to enable
%%  surface plotting
for i = 1:nRows
    for j = 1:nCols
        trueIndexes = find(bwArray(i,j,:) == 1);
        if isempty(trueIndexes) ~= 1
            maxZ(i,j) = max(trueIndexes);
            minZ(i,j) = min(trueIndexes);
        end
    end
end
            
surf(xData, yData, maxZ), hold on
surf(xData, yData, minZ)