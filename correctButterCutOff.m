function[fcut2] = Fcorrectcutoff(fcut, order);

%   Gives the true cutoff frequency [fcut2] that needs to be specified
%   for inputs into matfiltfilt in order to achieve the desired cutoff 
%   frequency [fcut].

%   Peter Mills
%   22 July, 2003.

fcut2 = fcut*(sqrt(2)-1)^(0.5/4);