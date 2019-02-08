function bw = scale2binary(inputArray, threshold);

if ndims(inputArray) == 2
    minVal = min(min(inputArray));
    inputArray = inputArray-minVal;
    maxVal = max(max(inputArray));
    inputArray = inputArray/maxVal;
elseif ndims(inputArray) == 3
    minVal = min(min(min(inputArray)));
    inputArray = inputArray-minVal;
    maxVal = max(max(max(inputArray)));
    inputArray = inputArray/maxVal;
end
bw = zeros(size(inputArray));
bw(inputArray>=threshold) = 1;

