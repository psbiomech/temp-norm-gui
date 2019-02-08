h = minMax2dPlot(x, y, includeMin, includeMax, lineColour, minColour, maxColour)

plot(x, y, lineColour)
hold on

if lower(includeMin) == 'y'
    [minY, indexMinY] = min(y)
    plot(x(minY), y(minY), minColour)
end

if lower(includeMax) == 'y'
    [maxY, indexMaxY] = max(y)
    plot(x(maxY), y(maxY), maxColour)
end

