function SendMessage( S, message )

value = 0;
for m =  1 : length(message)
    value = value + S.ParPortMessages.(message{m});
end

WriteParPort(value);
WaitSecs(S.ParPortMessages.DURATION);
WriteParPort(0);

end % function
