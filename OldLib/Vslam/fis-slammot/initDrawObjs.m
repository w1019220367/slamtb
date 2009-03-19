% INITDRAWOBJS  Initialize graphics for map landmarks

% points
for i=1:maxObj
    dispMapObj.elli(i) = line(...
        'parent',ax1,...
        'xdata',[],...
        'ydata',[],...
        'zdata',[],...
        'color',[1 1 .2],...
        'marker','none',...
        'linestyle','-',...
        'linewidth',1);
end

dispMapObj.center = line(...
    'parent',ax1,...
    'xdata',[],...
    'ydata',[],...
    'zdata',[],...
    'color',[1 1 0],...
    'marker','.',...
    'linestyle','none');