function Core( hObject, ~ )
% This is the main program, calling the different tasks and routines,
% accoding to the paramterts defined in the GUI


%% Retrieve GUI data
% I prefere to do it here, once and for all.

handles = guidata( hObject );


%% Clean the environment

clc
sca
rng('default')
rng('shuffle')


%% Initialize the main structure

% NOTES : Here I made the choice of using a "global" variable, because it
% simplifies a lot all the functions. It allows retrieve of the variable
% everywhere, and make lighter the input paramters.

global S
S                 = struct; % S is the main structure, containing everything usefull, and used everywhere
S.TimeStampSimple = datestr(now, 'yyyy-mm-dd HH:MM'); % readable
S.TimeStampFile   = datestr(now, 30                ); % yyyymmddTHHMMSS : to sort automatically by time of creation


%% Lots of get*

S.Task            = GUI.CONTROLLER.getTask         ( hObject );
S.SaveMode        = GUI.CONTROLLER.getSaveMode     ( handles );
S.InputMehtod     = GUI.CONTROLLER.getInputMethod  ( handles );
S.Show            = GUI.CONTROLLER.getShow         ( handles );
S.OperationMode   = GUI.CONTROLLER.getOperationMode( handles );
S.MovieMode       = GUI.CONTROLLER.getMovieMode    ( handles );
S.ScreenID        = GUI.CONTROLLER.getScreenID     ( handles );
S.WindowedMode    = GUI.CONTROLLER.getWindowedMode ( handles );
S.EyelinkMode     = GUI.CONTROLLER.getEyelinkMode  ( handles );
S.ParPort         = GUI.CONTROLLER.getParPort      ( handles );


%% Subject ID & Run number

[ S.SubjectID, ~, S.dirpath_SubjectID ] = GUI.CONTROLLER.getSubjectID( handles );

if S.SaveMode && strcmp(S.OperationMode,'Acquisition')

    if ~exist(S.dirpath_SubjectID, 'dir')
        mkdir(S.dirpath_SubjectID);
    end

end

DataFile_noRun  = sprintf('%s_%s_%s', S.SubjectID, S.InputMehtod, S.Task );
S.RunNumber     = GUI.MODEL.getRunNumber( S.dirpath_SubjectID, DataFile_noRun );
S.DataFileFPath = sprintf('%s%s_%s_%s_%s_run%0.2d', S.dirpath_SubjectID, S.TimeStampFile, S.SubjectID, S.InputMehtod, S.Task, S.RunNumber );
S.DataFileName  = sprintf(  '%s_%s_%s_%s_run%0.2d',                      S.TimeStampFile, S.SubjectID, S.InputMehtod, S.Task, S.RunNumber );


%% Quick warning

% Acquisition => save data
if strcmp(S.OperationMode,'Acquisition') && ~S.SaveMode
    warning('In acquisition mode, data should be saved')
end


%% Parallel port ?

if S.ParPort
    S.ParPortMessages = PARPORT.Prepare();
end


%% Eyelink ?

if S.EyelinkMode

    % 'Eyelink.m' exists ?
    assert( ~isempty(which('Eyelink.m')), 'no ''Eyelink.m'' detected in the path')

    % Save mode ?
    assert( SaveMode ,' \n ---> Save mode should be turned ON when using Eyelink <--- \n ')

    % Eyelink connected ?
    Eyelink.IsConnected();

    % Generate the Eyelink filename
    eyelink_max_finename = 8;                                                       % Eyelink filename must be 8 char or less...
    available_char        = ['a':'z' 'A':'Z' '0':'9'];                              % This is all characters available (N=62)
    name_num              = randi(length(available_char),[1 eyelink_max_finename]); % Pick 8 numbers, from 1 to N=62 (same char can be picked twice)
    name_str              = available_char(name_num);                               % Convert the 8 numbers into char

    % Save it
    S.EyelinkFile = name_str;

end


%% Security : NEVER overwrite a file
% If erasing a file is needed, we need to do it manually

if S.SaveMode && strcmp(S.OperationMode,'Acquisition')
    assert( ~exist([S.DataFileFPath '.mat'],'file'), ' \n ---> \n The file %s.mat already exists .  <--- \n \n', S.DataFileFPath );
end


%% Open PTB window & sound, if need
% comment/uncomment as needed

PTB_ENGINE.VIDEO.Parameters(); % <= here is all paramters
PTB_ENGINE.VIDEO.OpenWindow(); % this opens the windows and setup the drawings according the the paramters above

% Get screen physical settings & compute va2pix
cfg = screen_config();
S.PTB.Video.ScreenWidth    = cfg.width;
S.PTB.Video.ScreenHeight   = cfg.height;
S.PTB.Video.ScreenDistance = cfg.distance;
S.PTB.Video.VAvertical     = 2*atan(S.PTB.Video.ScreenHeight/2 / S.PTB.Video.ScreenDistance) * 180/pi; % degree
S.PTB.Video.va2pix         = S.PTB.Video.wRect(4) / S.PTB.Video.VAvertical;

% PTB_ENGINE.AUDIO.         Initialize(); % !!! This must be done once before !!!
% PTB_ENGINE.AUDIO.PLAYBACK.Parameters(); % <= here is all paramters
% PTB_ENGINE.AUDIO.PLAYBACK.OpenDevice(); % this opens the playback device (speakers/headphones) and setup according the the paramters above
% PTB_ENGINE.AUDIO.RECORD  .Parameters(); % <= here is all paramters
% PTB_ENGINE.AUDIO.RECORD  .OpenDevice(); % this opens the record device (microphone) and setup according the the paramters above

PTB_ENGINE.KEYBOARD.Parameters(); % <= here is paramters non Task specific


%% Everything is read, start Task

EchoStart(S.Task)

if strcmp(S.Task, 'EyelinkCalibration')
    Eyelink.Calibration(S.PTB.Video.wPtr);
    S.TaskData.ER.Data = {};
else
    % TASK.(S.Task).Parameters <= here is all paramters
    TASK.(S.Task).Runtime() % execution of the task
end

EchoStop(S.Task)


%% Save the file on the fly, without any prcessing => just a security

save( fullfile(fileparts(pwd),'data','lastS.mat') , 'S' )


%% Stop PTB engine

% Video : comment/uncomment
sca;
Priority(0);

% Audio : comment/uncomment
% PsychPortAudio('Close');


%% Save file, no post-processing
if S.SaveMode && strcmp(S.OperationMode,'Acquisition')
    save( S.DataFileFPath, 'S'); % complet file
end
assignin('base', 'S', S);


%% Save behavior

if S.SaveMode && strcmp(S.OperationMode,'Acquisition')
    t = S.BR.data2table();
    writetable(t, S.DataFileFPath, 'WriteVariableNames', true, 'Delimiter','\t')
    movefile([S.DataFileFPath '.txt'], [S.DataFileFPath '.tsv'])
end


%% Post-processing : generate all models for SPM

% block design
if exist(fullfile('+TASK',['+' S.Task],'SPMnod_block.m'),'file') > 0

    [ names , onsets , durations ] = TASK.(S.Task).SPMnod_block();

    if S.SaveMode && strcmp(S.OperationMode,'Acquisition')
        save([S.DataFileFPath '_SPM_block']     , 'names', 'onsets', 'durations'); % light weight file with only the onsets for SPM
    end

    assignin('base', 'names'    , names    );
    assignin('base', 'onsets'   , onsets   );
    assignin('base', 'durations', durations);

end

% event related
if exist(fullfile('+TASK',['+' S.Task],'SPMnod_event.m'),'file') > 0

    [ names , onsets , durations ] = TASK.(S.Task).SPMnod_event();

    if S.SaveMode && strcmp(S.OperationMode,'Acquisition')
        save([S.DataFileFPath '_SPM_event']     , 'names', 'onsets', 'durations'); % light weight file with only the onsets for SPM
    end

    assignin('base', 'names'    , names    );
    assignin('base', 'onsets'   , onsets   );
    assignin('base', 'durations', durations);

end

% parametric modulation
if exist(fullfile('+TASK',['+' S.Task],'SPMnod_parametric.m'),'file') > 0

    [ names , onsets , durations, pmod, orth, tmod ] = TASK.(S.Task).SPMnod_parametric();

    if S.SaveMode && strcmp(S.OperationMode,'Acquisition')
        save([S.DataFileFPath '_SPM_parametric']     , 'names', 'onsets', 'durations', 'pmod', 'orth', 'tmod'); % light weight file with only the onsets for SPM
    end

    assignin('base', 'names'    , names    );
    assignin('base', 'onsets'   , onsets   );
    assignin('base', 'durations', durations);
    assignin('base', 'pmod'     , pmod     );
    assignin('base', 'orth'     , orth     );
    assignin('base', 'tmod'     , tmod     );

end


%% Eyelink : stop recording

% Eyelink mode 'On' ?
if S.EyelinkMode

    % Stop recording and retrieve the file
    Eyelink.StopRecording( S.EyelinkFile )

end


%% ParPort : close

if S.ParPort
    CloseParPort();
end


%% Mic : write file

% audiodata = [S.BR.Data{:,6}];
% audiowrite([S.DataFileFPath '.wav'],audiodata,S.PTB.Audio.Record.SamplingFrequency)


%% Ready for another run

set(handles.text_LastFileNameAnnouncer, 'Visible', 'on')
set(handles.text_LastFileName         , 'Visible', 'on')
set(handles.text_LastFileName         , 'String' , S.DataFileName)

disp(S.BR.data2table)

WaitSecs(0.100);
pause(0.100);
fprintf('\n')
fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~ \n')
fprintf('    Ready for another run    \n')
fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~ \n')


end % function
