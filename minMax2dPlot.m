function minMax2dPlot(x, y, includeMin, includeMax, lineColour, minColour, maxColour)



if size(y, 2) == 0
    return
else
    
    plot(x, y, lineColour)
    hold on
    if lower(includeMin) == 'y'
        [minY, indexMinY] = min(y);
        h = plot(x(indexMinY), minY, eval(['''' minColour 'v''']));
        set(h, 'MarkerSize', 6, 'MarkerFaceColor', minColour);
    end

    if lower(includeMax) == 'y'
        [maxY, indexMaxY] = max(y);
        h = plot(x(indexMaxY), maxY, eval(['''' maxColour '^''']));
        set(h, 'MarkerSize', 6, 'MarkerFaceColor', maxColour);
    end   
end
