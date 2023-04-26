function [ ParPortMessages ] = Prepare()

% Open parallel port
OpenParPort();

% Set pp to 0
WriteParPort(0)


%% Prepare messages

msg.go    = '0 0 0 0   0 0 0 1';
msg.no    = '0 0 0 0   0 0 1 0';

msg.right = '0 0 0 0   0 1 0 0';
msg.down  = '0 0 0 0   1 0 0 0';
msg.free  = '0 0 0 0   1 1 0 0';



%% Finalize

% Pulse duration
msg.duration    = 0.003; % seconds

ParPortMessages = msg; % shortcut


end % function
