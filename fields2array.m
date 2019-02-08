function array = fields2array(parentStruct)

childNames = fieldnames(parentStruct);
for i = 1:length(childNames);
    array(:,i) = eval(['parentStruct.' char(childNames(i))]);
end
