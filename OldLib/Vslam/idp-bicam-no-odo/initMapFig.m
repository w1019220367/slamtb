% INITMAPFIG  Initialize visualization

robotSize  = 1;

% renderer = 'painters';
% renderer = 'zbuffer';
renderer = 'opengl';

bgndcolor = 'w';

Xm = -2;
XM = 60;
Ym = -6;
YM = 16;
Zm = -10;
ZM = 60;

initObserver;

% FIGURE 1
if ~ishandle(1)
    fig1 = figure(1);
    set(fig1,'position',[1 1 640 240]);
    %     'doublebuffer','on',...
    cameratoolbar('show');
    cameratoolbar('setmode','orbit');
else
    fig1 = figure(1);
end
set(fig1,...
    'renderer',renderer,...
    'toolbar','none',...
    'color',bgndcolor);
clf

% Axes
axis equal
ax1 = gca;
set(ax1,...
    'parent',fig1,...
    'position',[0 0 1 1],...
    'drawmode','fast',...
    'nextplot','replacechildren',...
    'projection',mapProj,...
	'CameraPosition',obsCam.X(1:WDIM),...
	'CameraPositionMode','manual',...
	'CameraTarget',obsTgt.X(1:WDIM),...
	'CameraTargetMode','manual',...
	'CameraUpVector',obsCam.upvec,...
	'CameraUpVectorMode','manual',...
	'CameraViewAngle',obsCam.a,...
	'CameraViewAngleMode','manual',...
    'xlim',[Xm XM],...
    'ylim',[Ym YM],...
    'zlim',[Zm ZM],...
    'xcolor',bgndcolor,...
    'ycolor',bgndcolor,...
    'zcolor',bgndcolor,...
    'color',bgndcolor);


% Ground
[x,y] = meshgrid(Xm:2:XM,Ym:2:YM);
z = zeros(size(x));
sh = surface(...
    'parent',ax1,...
    'XData',x,...
    'YData',y,...
    'ZData',z,...
    'FaceColor','none',...
    'EdgeColor',[.6 .8 .8],...
    'Marker','none');



% Estimated robot
trjCol = ['r' 'g'];

for i=1:2
    Rob(i).graphics = thickVehicle(robotSize);
    [te,Re] = getTR(Rob(i));
    Te = te*ones(1,size(Rob(i).graphics.vert0,1));
    Rob(i).graphics.vert = Rob(i).graphics.vert0*Re'+Te';
    dispEstRob(i) = patch(...
        'parent'   ,ax1,...
        'vertices' ,Rob(i).graphics.vert,...
        'faces'    ,Rob(i).graphics.faces,...
        'facecolor','b',...
        'visible'  ,'on'); % solid blue robot estimate
    
    % trajectory
    dispTraj(i) = line(...
        'parent',ax1,...
        'xdata',[],'ydata',[],'zdata',[],'color',trjCol(i));

end

% Camera in estimated robot
camBase      = [0;0;0];
for c = 1:length(Cam)
    camSensor  = Cam(c).X(1:WDIM);
    camPletine = [camBase(1:2);camSensor(3)];
    Cam(c).graphics = fromFrame(...
        Rob(c),...
        [camBase camPletine camSensor]); % a line from robot base to pletine to sensor
%     camGraph = [Cam.graphics];
    dispEstCam(c) = line(...
        'parent'   	     ,ax1,...
        'xdata'          ,Cam(c).graphics(1,:),...
        'ydata'          ,Cam(c).graphics(2,:),...
        'zdata'          ,Cam(c).graphics(3,:),...
        'linestyle'      ,'-',...
        'marker'         ,'none',...
        'color'          ,'m',...
        'visible'        ,'on'     ); % camera optical centers
end
    

% Map usage plot
if plotUsed
ax2 = axes(...
    'parent',fig1,...
    'position',[.07 .01 .45 .06],...
    'fontsize',7,...
    'fontweight','normal',...
    'xaxislocation','top',...
    'xcolor',[.4 .7 .4],...
    'ycolor',[.7 .4 .4],...
    'ticklength',[0 .02],...
    'ytick',[0.2 0.9],...
    'yticklabel',['FREE';'USED'],...
    'ylim',[0 1.1]);
    
    % usage in blue
    usedLm = line(...
        'parent',ax2,...
        'color','b',...
        'linewidth',1,...
        'xdata',1:Map.N,...
        'ydata',zeros(1,Map.N));
    
    % max used in red
    maxLm = line(...
        'parent',ax2,...
        'color','r',...
        'linewidth',3,...
        'xdata',[0 0],...
        'ydata',[0 1]);
    
    % set to main figure for camera control
    set(fig1,'currentaxes',ax1);
    
end

% Landmarks in map figure
initDrawMapLmks;