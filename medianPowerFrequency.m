function mF = medianPowerFrequency(f, p)

sumP = sum(p);

for i = 1:size(p,2)
    j = 1;
    while sum(p(1:j,i)) < sumP(i)/2
        j = j+1;
    end
    mF(i) = f(j);
end