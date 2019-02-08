function scaled = scale2binary(inputArray)

if ndims(inputArray) == 2
    minVal = min(min(inputArray));
    inputArray = inputArray-minVal;
    maxVal = max(max(inputArray));
    scaled = inputArray/maxVal;
elseif ndims(inputArray) == 3
    minVal = min(min(min(inputArray)));
    inputArray = inputArray-minVal;
    maxVal = max(max(max(inputArray)));
    scaled = inputArray/maxVal;
end


