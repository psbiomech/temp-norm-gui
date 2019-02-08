function rmsError = rmse(s1, s2);
%%   RMSE calculates the root mean squared error between a 1D vector S1 and 
%   a 1D or 2D matrix S2. 
%
%   rmsError = rmse(s1, s2) calculates the root mean squared error rmsError
%   between a reference vector S1 and a matrix S2. The length of S1 and S2
%   must be equal. 
%
%   Written by: Peter Mills (HMES UWA)
%   Last modified: 24 February, 2005

%%  Catch errors in size of input arguements
[nRows1, nCols1] = size(s1);

if nCols1 > 1
    error('s1 must be a 1D column vector');
end

[nRows2, nCols2] = size(s2);

if nRows1 ~= nRows2;
    error('The number of rows in s1 and s2 must be equal!');
end


%%  Calculate root mean squared error
for i = 1:nCols2
    rmsError(:,i) = mean(abs(s1 - s2(:,i)));
end