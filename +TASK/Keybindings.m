function Keybindings()
global S

switch S.Environement

    case 'MRI' %-----------------------------------------------------------

        switch S.Task

            case 'GoNogo'
                S.Keybinds.TaskSpecific.a = KbName('b'); % blue   in right hand
                S.Keybinds.TaskSpecific.b = KbName('y'); % yellow in left  hand

            case 'Reward'
                S.Keybinds.TaskSpecific.a = KbName('b'); % blue   in right hand
                S.Keybinds.TaskSpecific.b = KbName('y'); % yellow in left  hand

        end

    case 'Keyboard' %------------------------------------------------------
        switch S.Task

            case 'GoNogo'
                S.Keybinds.TaskSpecific.a = KbName('b'); % blue   in right hand
                S.Keybinds.TaskSpecific.b = KbName('y'); % yellow in left  hand

            case 'Reward'
                S.Keybinds.TaskSpecific.a = KbName('b'); % blue   in right hand
                S.Keybinds.TaskSpecific.b = KbName('y'); % yellow in left  hand

        end

end % function
