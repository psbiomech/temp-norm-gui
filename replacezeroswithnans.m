function newMarkers = replacezeroswithnans(markers)
%
%   newMarkers = replacezeroswithnans(markers)
%   REPLACEZEROSWITHNANS replaces zeros with NaNs
%
%   If markers is 3-dimensional array REPLACEZEROSWITHNANS will search across the
%   first two dimensions for instances of zeros in each column of the third dimension
%   and replaces those instances with NaNs. This function was created for use with 
%   PC-Real format c3d files in which frames missing marker data are zero padded. 
%   Markers and newMarkers are both be 3-dimensional matrices with axis (x,y,z) 
%   as the 3rd dimension. The original c3d file is not updated.
%
%   If markers is 2-dimensional array REPLACEZEROSWITHNANS searches across each three 
%   columns of data (e.g. markers(i,1:3) >> markers (i, 4:6) ... etc. for instances 
%   where the rows contain zeros and replaces the cells with NaN. Markers and 
%   newMarkers are both 2-dimensional arrays with time as the first (row)
%   dimension and triplets of 3d coordinates as the second (column)
%   dimension.

%   Written by: Peter Mills (HMES UWA)
%   Last modified: 12 August, 2004

newMarkers = markers;

if ndims(markers) == 3
    [l, m, n] = size(markers);
    for i = 1:l
        for j = 1:m
            if all(markers(i,j,1:3), 2) == 0
                newMarkers(i,j,1:3) = NaN;
            end
        end
    end
else 
    [m, n] = size(markers);
    if n > 1
        for i = 1:m
            for j = 1:3:n
                if all(markers(i,j:j+2)) == 0
                    newMarkers(i,j:j+2) = NaN;
                end
            end
        end
    else
        if any(markers) == 0
            newMarkers = nan(m, 1);
        end
    end
end            