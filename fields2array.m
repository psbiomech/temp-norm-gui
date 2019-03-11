function array = fields2array(parentStruct)


% Original code block - commented out by Prasanna Sritharan, March 2019 
%
%childNames = fieldnames(parentStruct);
%for i = 1:length(childNames);
%    array(:,i) = eval(['parentStruct.' char(childNames(i))]);
%end



% New code by Prasanna Sritharan, March 2019
%
% Need to account for force plate names that have one or more '.' in the
% name string. Uses the function fieldnamesr() by Adam Tudor-Jones.

% build list of struct paths (assume max depth 2)
treelist = fieldnamesr(parentStruct);

% compile data in structs into arrays
for t = 1:length(treelist)
   array(:,t) = eval(['parentStruct.' treelist{t}]);
end




