function [ ParPortMessages ] = Prepare()

% Close if if necessary
CloseParPort();

% Open parallel port
OpenParPort();

% Set pp to 0
WriteParPort(0)


%% Prepare messages

msg = struct;

msg.go                 = bin2dec('0 0 0 0   0 0 0 1');
msg.no                 = bin2dec('0 0 0 0   0 0 1 0');

msg.right              = bin2dec('0 0 0 0   0 1 0 0');
msg.down               = bin2dec('0 0 0 0   1 0 0 0');
msg.free               = bin2dec('0 0 0 0   1 1 0 0');

msg.ActionSelection    = bin2dec('0 0 0 1   0 0 0 0');
msg.FixationPeriod     = bin2dec('0 0 1 0   0 0 0 0');
msg.TargetAppearance   = bin2dec('0 0 1 1   0 0 0 0');
msg.ResponseCue        = bin2dec('0 1 0 0   0 0 0 0');
msg.Feedback           = bin2dec('0 1 0 1   0 0 0 0');
msg.InterTrialInterval = bin2dec('0 1 1 0   0 0 0 0');


%% Finalize

% Pulse duration
msg.DURATION    = 0.003; % seconds

ParPortMessages = msg; % shortcut


end % function
