function outNames = repminus(inNames)

outNames = inNames;
for i = 1:length(inNames);
    outName = char(outNames(i));
    minusIndex = findstr('-', outName);
    if isempty(minusIndex)
        continue
    else
        outName(minusIndex) = '_';
    end
    outNames(i) = cellstr(outName);
end
    
