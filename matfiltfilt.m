function [result] = matfiltfilt(dt, fcut, order, data);

% Requires Wn = [low f-cut, hi-fcut]

% perform double nth order butterworth filter on several columns of data

% the double filter should have 1/sqrt(2) transfer at fcut, so we
% need correction for filter order:

if order == 0
   fcut = fcut;
else
   fcut = fcut/(sqrt(2)-1)^(0.5/order);
end

Wn = 2*fcut*dt;

[b,a] = butter(order, Wn);

[n,m] = size(data);

for i=1:m
  result(:,i) = filtfilt(b,a,data(:,i));
end