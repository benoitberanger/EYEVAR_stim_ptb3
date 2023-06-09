function [ TriggerTime ] = WaitForTTL
global S

if strcmp(S.OperationMode,'Acquisition')
    
    disp('----------------------------------')
    disp('      Waiting for trigger "t"     ')
    disp('                OR                ')
    disp('   Press "s" to emulate trigger   ')
    disp('      Press "Escape" to abort     ')
    disp('----------------------------------')
    disp(' ')
    
    % Eyelink : start recording
    if S.EyelinkMode
        Eyelink.storeELfilename(S.dirpath_SubjectID, S.EyelinkFile, S.DataFileName);
        Eyelink.StartRecording(S.EyelinkFile); % Stop wrapper
    end
    
    % Just to be sure the user is not pushing a button before
    WaitSecs(0.200); % secondes
    
    % Waiting for TTL signal
    while 1
        
        [ keyIsDown , TriggerTime, keyCode ] = KbCheck;
        
        if keyIsDown
            
            %             switch S.Environement
            %
            %                 case 'MRI'
            
            if keyCode(S.Keybinds.Common.TTL_t) || keyCode(S.Keybinds.Common.emulTTL_s)
                
                disp('==> Trigger received <==')
                break
                
            elseif keyCode(S.Keybinds.Common.Stop_Escape)
                
                % Eyelink mode 'On' ?
                if S.EyelinkMode
                    Eyelink.STOP(); % Stop wrapper
                end
                
                sca
                stack = dbstack;
                error('WaitingForTTL:Abort','\n ESCAPE key : %s aborted \n',stack.file)
                
            end
            
        end
        
    end % while
    
    
else % in DebugMod
    
    disp('Waiting for TTL : DebugMode')
    
    TriggerTime = GetSecs();
    
end

end % function
