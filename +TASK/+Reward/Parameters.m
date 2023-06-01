function [ EP, TaskParam ] = Parameters( OperationMode, InputMethod, Congruency, HighRewarded )
global S

if nargin < 1 % only to plot the paradigme when we execute the function outside of the main script
    OperationMode = 'Acquisition';
    InputMethod = 'eyetracker';
    Congruency = 'congruent';
    HighRewarded = 'right';
end

p = struct; % This structure will contain all task specific parameters, such as Timings and Graphics


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODIFY FROM HERE....
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%free and instructed

p.Conditions = {
    'free'  6
    'right' 2
    'down'  2
    };

p.nRep = 8;


%% Timings

switch InputMethod

    case 'eyetracker'

        % all dur_* are in seconds
        p.dur_ActionSelection            = 2.000 + [-0.500 +0.500];

        p.dur_FixationPeriod_MinimumStay = 0.100; % gaze
        p.dur_FixationPeriod_Maximum     = 0.200 + [-0.100 +0.100]; % got to next trial

        p.dur_TargetAppearance           = 0.400 + [-0.200 +0.200];

        p.dur_ResponseCue_Maximum        = 0.500;
        p.dur_ResponseCue_Go_MinimumStay = 0.100;

        p.dur_Feedback                   = 0.200;                      % smiley display duration

        p.dur_Reward                     = 0.700;

        p.dur_InterTrailInterval         = 6.000 + [-1.500 +1.500];

    case 'mouse'

        % all dur* are in seconds
        p.dur_ActionSelection            = 2.000 + [-0.500 +0.500];

        p.dur_FixationPeriod_MinimumStay = 0.100; % gaze
        p.dur_FixationPeriod_Maximum     = 0.200 + [-0.100 +0.100]; % got to next trial

        p.dur_TargetAppearance           = 0.400 + [-0.200 +0.200];

        p.dur_ResponseCue_Maximum        = 1.500;
        p.dur_ResponseCue_Go_MinimumStay = 0.500;

        p.dur_Feedback                   = 0.200;                      % smiley display duration

        p.dur_Reward                     = 0.500;

        p.dur_InterTrailInterval         = 6.000 + [-1.500 +1.500];

    otherwise
        error('input method ?')

end

%% Debugging

switch OperationMode
    case 'FastDebug'
        p.nRep = 1;
        p.dur_ActionSelection    = 1.000 + [-0.500 +0.500];
        p.dur_InterTrailInterval = 1.000 + [-0.500 +0.500];
    case 'RealisticDebug'
        p.nRep = 1;
    case 'Acquisition'
        % pass
    otherwise
        error('mode ?')
end


%% Graphics
% graphic parameters are in a sub-function because they are common across tasks

p = TASK.Graphics( p );


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ... TO HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nTrial_per_rep = sum(cell2mat(p.Conditions(:,2)));
p.nTrial = nTrial_per_rep * p.nRep;


%% Jitters

fields = fieldnames(p);

for f = 1 : length(fields)
    field = fields{f};

    if length(field)>=4 && strcmp(field(1:4), 'dur_')
        if isvector(p.(field)) && length(p.(field)) == 2
            min_max = p.(field);
            p.jitters.(field) = Shuffle(linspace(min_max(1),min_max(2), p.nTrial));
        end
    end

end


%% Build planning

% Create and prepare
header = {'event_name', 'onset(s)', 'duration(s)',...
    'congruency', 'highrewarded', 'iTrial', 'iBlock', 'idx'};
EP     = EventPlanning(header);

% NextOnset = PreviousOnset + PreviousDuration
NextOnset = @(EP) EP.Data{end,2} + EP.Data{end,3};

% --- Start ---------------------------------------------------------------

EP.AddStartTime('StartTime',0);

% --- Stim ----------------------------------------------------------------

iTrial = 0;
for iBlock = 1 : p.nRep

    cond = cell(nTrial_per_rep,1);
    c = 0;
    for i1 = 1 : size(p.Conditions,1)
        for i2 = 1 : p.Conditions{i1,2}
            c = c + 1;
            cond(c,:) = p.Conditions(i1,1);
        end
    end

    cond = Shuffle(cond,2);

    for c = 1 : size(cond,1)
        iTrial = iTrial + 1;
        EP.AddEvent({ cond{c,1} NextOnset(EP) 10 ...
            Congruency HighRewarded iTrial iBlock c})
    end

end

% --- Stop ----------------------------------------------------------------

EP.AddStopTime('StopTime',NextOnset(EP));

EP.BuildGraph();


%% Display

% To prepare the planning and visualize it, we can execute the function
% without output argument

if nargin < 1

    fprintf( '\n' )
    fprintf(' \n Total stim duration : %g seconds \n' , NextOnset(EP) )
    fprintf( '\n' )

    EP.Plot();

end


%% Save

TaskParam = p;

S.EP        = EP;
S.TaskParam = TaskParam;


end % function
