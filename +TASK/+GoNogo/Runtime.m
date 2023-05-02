function Runtime()
global S

try
    %% Tuning of the task

    TASK.Keybindings();
    [ EP, p ] = TASK.GoNogo.Parameters( S.OperationMode, S.InputMehtod );


    %% Prepare recorders

    PTB_ENGINE.PrepareRecorders( S.EP );
    S.BR = EventRecorder({'iTrial', 'iBlock', 'idx', 'condition', 'direction', 'state', 'dur_expected', 'dur_real', 'onset' 'gaze_fixed' 'smiley'}, p.nTrial * 10);


    %% Initialize stim objects

    FIXATIONCROSS = TASK.PREPARE.FixationCross();
    WALL_E        = TASK.PREPARE.WALL_E();
    EVE           = TASK.PREPARE.EVE(WALL_E);
    SAURON        = TASK.PREPARE.SAURON();


    %% Shortcuts

    ER          = S.ER; % EventRecorder
    BR          = S.BR; % BehaviourRecorder (EventRecorder)
    SR          = SAURON.recorder;
    S.SR        = SR;
    wPtr        = S.PTB.Video.wPtr;
    wRect       = S.PTB.Video.wRect;
    slack       = S.PTB.Video.slack;
    KEY_ESCAPE  = S.Keybinds.Common.Stop_Escape;
    if S.MovieMode, moviePtr = S.moviePtr; end


    %% Planning columns

    columns = struct;
    for c = 1 : EP.Columns
        col_name = matlab.lang.makeValidName( EP.Header{c} );
        columns.(col_name) = c;
    end


    %% GO

    EXIT = false;
    secs = GetSecs();

    % Loop over the EventPlanning
    nEvents = size( EP.Data , 1 );
    for evt = 1 : nEvents

        % Shortcuts
        evt_name     = EP.Data{evt,columns.event_name};
        evt_onset    = EP.Data{evt,columns.onset_s_};
        evt_duration = EP.Data{evt,columns.duration_s_};
        evt_iTrial   = EP.Data{evt,columns.iTrial};
        evt_iBlock   = EP.Data{evt,columns.iBlock};
        evt_idx      = EP.Data{evt,columns.idx};

        if evt < nEvents
            next_evt_onset = EP.Data{evt+1,columns.onset_s_};
        end

        switch evt_name

            case 'StartTime' % --------------------------------------------

                % Draw
                FIXATIONCROSS.Draw();
                Screen('DrawingFinished', wPtr);
                Screen('Flip',wPtr);

                if strcmp(SAURON.type, 'mouse')
                    SetMouse( SAURON.screen_x/2, SAURON.screen_y/2, SAURON.wPtr )
                end

                StartTime = PTB_ENGINE.StartTimeEvent(); % a wrapper, deals with hidemouse, eyelink, mri sync, ...
                SAURON.starttime = StartTime;


            case 'StopTime' % ---------------------------------------------

                StopTime = GetSecs();

                % Record StopTime
                S.ER.AddStopTime( 'StopTime' , StopTime - StartTime );


            case {'free_go', 'free_no', 'right_go','right_no', 'left_go','left_no', 'up_go','up_no', 'down_go','down_no'}

                res = strsplit(evt_name,'_');
                condition = res{2};
                direction = res{1};
                next_event = StartTime + next_evt_onset - slack;

                % log
                fprintf('trial=%3d // block=%2d // idx=%1d // direction=%5s // condition=%2s \n', ...
                    evt_iTrial, evt_iBlock, evt_idx, direction, condition)

                state = 'ActionSelection';
                frame_counter = 0;
                next_onset = +Inf;
                logit = '';
                gaze_fixed = NaN;
                smiley = ' ';

                while secs < next_event

                    [keyIsDown, secs, keyCode] = KbCheck();
                    if keyIsDown
                        EXIT = keyCode(KEY_ESCAPE);
                        if EXIT, break, end
                    end
                    frame_counter = frame_counter + 1;

                    [gaze_x, gaze_y] = SAURON.Update();

                    switch state

                        case 'ActionSelection' %---------------------------

                            WALL_E.DrawFrameSquare('white');
                            WALL_E.DrawImage(direction);

                            if frame_counter == 1
                                next_state = 'FixationPeriod';
                            elseif frame_counter == 2
                                dur_expected = p.jitters.dur_ActionSelection(evt_iTrial);
                                next_onset = state_onset + dur_expected;
                            end

                        case 'FixationPeriod' %----------------------------

                            WALL_E.DrawFrameSquare('white');
                            WALL_E.DrawImage(direction);

                            if frame_counter == 1
                                next_state = 'InterTrialInterval';
                                fixation_duration = 0;
                            elseif frame_counter == 2
                                dur_expected = p.jitters.dur_FixationPeriod_Maximum(evt_iTrial);
                                next_onset = state_onset + dur_expected;
                            end

                            if IsInRect(gaze_x, gaze_y, WALL_E.windowRect)
                                fixation_duration = fixation_duration + S.PTB.Video.IFI;

                                if fixation_duration >= p.dur_FixationPeriod_MinimumStay
                                    gaze_fixed = +1;
                                    logit = state;
                                    state = 'TargetAppearance';
                                    fixation_duration = 0;
                                    frame_counter = 0;
                                end

                            else
                                fixation_duration = 0;
                            end

                        case 'TargetAppearance' %--------------------------

                            WALL_E.DrawFillSquare('white');
                            WALL_E.DrawImage(direction);
                            EVE.DrawFillSquare('down');
                            EVE.DrawFillSquare('right');

                            if frame_counter == 1
                                next_state = 'ResponseCue';
                            elseif frame_counter == 2
                                dur_expected = p.jitters.dur_TargetAppearance(evt_iTrial);
                                next_onset = state_onset + dur_expected;
                            end

                        case 'ResponseCue' %-------------------------------

                            EVE.DrawFillSquare('down');
                            EVE.DrawFillSquare('right');
                            switch condition
                                case 'go'
                                    WALL_E.DrawFillSquare('green')

                                case 'no'
                                    WALL_E.DrawFillSquare('red')

                            end

                            if frame_counter == 1
                                next_state = 'Feedback';
                                fixation_duration = 0;
                                gaze_fixed = -1;
                                smiley = 'sad';
                            elseif frame_counter == 2
                                dur_expected = p.dur_ResponseCue_Maximum;
                                next_onset = state_onset + dur_expected;
                            end

                            switch condition
                                case 'go'

                                    switch direction
                                        case 'free'
                                            isinrect_down  = IsInRect(gaze_x, gaze_y, EVE.windowRect.down );
                                            isinrect_right = IsInRect(gaze_x, gaze_y, EVE.windowRect.right);
                                            isinrect = isinrect_down + isinrect_right;
                                        otherwise
                                            isinrect = IsInRect(gaze_x, gaze_y, EVE.windowRect.(direction));
                                    end

                                    if isinrect
                                        fixation_duration = fixation_duration + S.PTB.Video.IFI;

                                        if fixation_duration >= p.dur_ResponseCue_Go_MinimumStay
                                            gaze_fixed = +1;
                                            logit = state;
                                            state = 'Feedback';
                                            smiley = 'happy';
                                            fixation_duration = 0;
                                            frame_counter = 0;
                                        end
                                    end

                                    if fixation_duration > 0 && ~isinrect % in the target, then out -> FAIL
                                        gaze_fixed = -1;
                                        smiley = ' ';
                                        logit = state;
                                        state = 'InterTrialInterval';
                                        fixation_duration = 0;
                                        frame_counter = 0;
                                    elseif frame_counter > 2 && fixation_duration == 0 && (next_onset-flip_onset) < p.dur_ResponseCue_Go_MinimumStay % no time left to reach the target
                                        gaze_fixed = -1;
                                        logit = state;
                                        state = 'Feedback';
                                        smiley = 'sad';
                                        fixation_duration = 0;
                                        frame_counter = 0;
                                    end

                                case 'no'

                                    if IsInRect(gaze_x, gaze_y, WALL_E.windowRect)
                                        fixation_duration = fixation_duration + S.PTB.Video.IFI;

                                        if fixation_duration >= p.dur_ResponseCue_No_MinimumStay
                                            gaze_fixed = +1;
                                            logit = state;
                                            state = 'Feedback';
                                            smiley = 'happy';
                                            fixation_duration = 0;
                                            frame_counter = 0;
                                        end

                                    else
                                        fixation_duration = 0;
                                    end
                            end

                        case 'Feedback' %-----------------------------------

                            EVE.DrawImage(smiley, 'center')

                            if frame_counter == 1
                                next_state = 'InterTrialInterval';
                            elseif frame_counter == 2
                                dur_expected = p.dur_Feedback;
                                next_onset = state_onset + dur_expected;
                            end

                        case 'InterTrialInterval' %------------------------

                            FIXATIONCROSS.Draw();

                            if frame_counter == 1
                                next_state = '';
                            elseif frame_counter == 2
                                dur_expected = p.jitters.dur_InterTrailInterval(evt_iTrial);
                                next_onset = state_onset + dur_expected;
                            end

                        otherwise %----------------------------------------
                            error('state ?')

                    end

                    if S.Show
                        SAURON.Draw();
                    end

                    Screen('DrawingFinished', wPtr);
                    flip_onset = Screen('Flip', wPtr);

                    if frame_counter == 1
                        if S.ParPort
                            PARPORT.SendMessage(S, {condition, direction, state})
                        end

                        fprintf('%s ', state) % log

                        state_onset = flip_onset;

                        % save trial onset
                        if strcmp(state, 'ActionSelection')
                            ER.AddEvent({evt_name state_onset-StartTime [] EP.Data{evt, 4:end}})
                        end

                    end

                    if frame_counter > 2  &&  (flip_onset + slack >= next_onset)
                        logit = state;
                        state = next_state;
                        frame_counter = 0;
                    end

                    if logit
                        S.BR.AddEvent({evt_iTrial evt_iBlock evt_idx direction condition logit dur_expected flip_onset-state_onset state_onset-StartTime gaze_fixed smiley})
                        if strcmp(logit, 'Feedback')
                            smiley = ' ';
                        end
                        logit = '';
                        gaze_fixed = NaN;
                    end

                    if isempty(state)
                        % log
                        fprintf('\n')
                        break
                    end


                end % while

            otherwise % ---------------------------------------------------

                error('unknown envent')

        end % switch

        % if ESCAPE is pressed
        if EXIT
            StopTime = secs;

            % Record StopTime
            ER.AddStopTime( 'StopTime', StopTime - StartTime );

            Priority(0);

            fprintf('ESCAPE key pressed \n');
            break
        end

    end % for


    %% End of task execution stuff

    % Save some values
    S.StartTime = StartTime;
    S.StopTime  = StopTime;

    PTB_ENGINE.FinilizeRecorders();

    % Close parallel port
    if S.ParPort, CloseParPort(); end

    % Diagnotic
    switch S.OperationMode
        case 'Acquisition'
        case 'FastDebug'
            % plotDelay(EP,ER);
        case 'RealisticDebug'
            % plotDelay(EP,ER);
    end

    try % I really don't want to this feature to screw a standard task execution
        if exist('moviePtr','var')
            PTB_ENGINE.VIDEO.MOVIE.Finalize(moviePtr);
        end
    catch
    end


    %% Close PTB textures

    WALL_E.CloseTextures();
    EVE.CloseTextures();


catch err

    sca;
    Priority(0);

    rethrow(err);

    if exist('moviePtr','var') %#ok<UNRCH>
        PTB_ENGINE.VIDEO.MOVIE.Finalize(moviePtr);
    end

end % try

end % function
