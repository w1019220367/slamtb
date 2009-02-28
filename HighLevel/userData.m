% USERDATA  User data for universal SLAM.
%   Edit this file to enter the information you need for SLAM. Variable
%   names and comments should make this file easy to understand. Follow
%   these guidelines:
%
%   * Specify site, run and estimation details
%   * Specify sampling time and start and end frames.
%   * Use as many robots and sensors as you wish.
%   * Assign sensors to robots via Rob{i}.sensorList.
%   * Use field Sens{i}.d for radial distortion parameters if desired.
%   * Define one instance of each landmark type you wish to use. Use the
%   field Lmk{i}.naxNbr to specify the maximum number of such landmarks
%   that the SLAM map must support.

%   (c) 2009 Joan Sola @ LAAS-CNRS

% Experiment names 
%   - site name, series gathered, estimation run number 
Experiment = struct(...
    'site',                 'expname',...   % Name of the site
    'dataRun',              1,...           % Run nbr on site
    'estimateRun',          1,...           % slam run for data and site
    'lmkTypes',             'idp',...       % types of landmarks used
    'sensingType',          'mono',...      % sensing mode
    'mappingType',          'single');      % mapping mode

% Time variables 
%   - sampling time, first and last frames
Time = struct(...
    'dt',                   1,...           % sampling time
    'firstFrame',           1,...           % first frame #
    'lastFrame',            100);           % last frame #

% Simulated world
%   - Simulation landmark sets, playground dimensions
World = struct(...
    'xmin',                 -20,...         % playground limits
    'xmax',                 20,...
    'ymin',                 -20,...
    'ymax',                 20,...
    'zmin',                 -10,...
    'zmax',                 20,...
    'points',               thickCloister(-5,5,-5,5,2,9),...    % point lmks
    'segments',             zeros(6,0));    % segment lmks

% Sensor things 
%   - each sensor's type and parameters, noise, non-measurable prior
Sensor{1} = struct(...
    'name',                 'Dala',...      % sensor name
    'type',                 'pinHole',...   % type of sensor
    'id',                   1,...           % sensor identifier
    'position',             [0;0;0],...     % position in robot
    'orientationDegrees',   [0;0;0],...     % orientation in robot, roll pitch yaw
    'positionStd',          [0;0;0],...     % position error std
    'orientationStd',       [0;0;0],...     % orient. error std
    'imageSize',            [640;480],...   % image size
    'pixErrorStd',          1.0,...         % pixel error std
    'intrinsic',            [320;320;200;200],...   % intrinsic params
    'distortion',           [],...          % distortion params
    'frameInMap',           false);         % add sensor frame in slam map?
Sensor{2} = struct(...
    'name',                 'Dala',...      % sensor name
    'type',                 'pinHole',...   % type of sensor
    'id',                   2,...           % sensor identifier
    'position',             [0;0;0],...     % position in robot
    'orientationDegrees',   [0;0;0],...     % orientation in robot, roll pitch yaw
    'positionStd',          [0;0;0],...     % position error std
    'orientationStd',       [0;0;0],...     % orient. error std
    'imageSize',            [640;480],...   % image size
    'pixErrorStd',          1.0,...         % pixel error std
    'intrinsic',            [320;320;200;200],...   % intrinsic params
    'distortion',           [],...          % distortion params
    'frameInMap',           true );         % add sensor frame in slam map?

% Robot things 
%   - each robot's type and initial config, controls
Robot{1} = struct(...
    'name',                 'Dala',...      % robot name
    'type',                 'constVel',...  % motion model, type of robot
    'id',                   1,...           % robot identifier
    'position',             [0;0;0],...     % robot position in map
    'orientationDegrees',   [0;0;0],...     % orientation, in degrees, roll pitch yaw.
    'positionStd',          [0;0;0],...     % position error, std
    'orientationStd',       [0;0;0],...     % orient. error, std
    'velocity',             [0;0;0],...     % lin. velocity
    'angularVelDegrees',    [0;0;0],...     % ang. velocity
    'velStd',               [0;0;0],...     % lin. vel. error, std
    'angVelStd',            [0;0;0],...     % ang. vel. srroe, std
    'sensorsList',          1);             % list of sensors in robot
Robot{2} = struct(...
    'name',                 'Dala',...      % robot name
    'type',                 'constVel',...  % motion model, type of robot
    'id',                   2,...           % robot identifier
    'position',             [0;0;0],...     % robot position in map
    'orientationDegrees',   [0;0;0],...     % orientation, in degrees, roll pitch yaw.
    'positionStd',          [0;0;0],...     % position error, std
    'orientationStd',       [0;0;0],...     % orient. error, std
    'velocity',             [0;0;0],...     % lin. velocity
    'angularVelDegrees',    [0;0;0],...     % ang. velocity
    'velStd',               [0;0;0],...     % lin. vel. error, std
    'angVelStd',            [0;0;0],...     % ang. vel. srroe, std
    'sensorsList',          2);             % list of sensors in robot
    
% Landmark things 
%   - landmark types, max nbr of lmks, lmk management options
Landmark{1} = struct(...
    'type',                 'idpPnt',...    % type of landmark
    'nonObsMean',           1e-5,...        % mean of non obs. for initialization
    'nonObsStd',            0.5,...         % std of non obs for initialization
    'maxNbr',               20);            % max. nbr. of lmks of this type in map
Landmark{2} = struct(...
    'type',                 'eucPnt',...    % type of landmark
    'maxNbr',               100);           % max. nbr. of lmks of this type in map
    
% Visualization options 
%   - view, projection, video, ellipses
MapView{1} = struct(...
    'projection',           'persp',...     % projection of the 3d figure
    'view',                 'norm');        % viewpoint
SensorView{1} = struct(...
    'ellipses',             true);          % show 3d ellipsoids?
Video = struct(...
    'createVideo',          false);         % create video sequence?

% Estimation options 
%   - random, reprojection, active search, etc
Estimation = struct(...
    'random',               true,...        % use true random generator?
    'fixedRandomSeed',      1,...           % random seed for non-random runs
    'reprojectLmks',        true,...        % reproject lmks after active search?
    'warpMethod',           'jacobian');    % patch warping method
