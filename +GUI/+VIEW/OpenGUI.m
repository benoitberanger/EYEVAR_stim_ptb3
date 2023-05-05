function varargout = OpenGUI()
% OpenGUI is the function that creates (or bring to focus) GUI.
% Then, GUI.MODEL.Core() is always called to start each task. It is the
% "main" program.

% debug=1 closes previous figure and reopens it, and send the gui handles
% to base workspace.
debug = 0;

gui_name = [ 'GUI_' project_name() ];


%% Open a singleton figure, or gring the actual into focus.

% Is the GUI already open ?
figPtr = findall(0,'Tag',gui_name);

if ~isempty(figPtr) % Figure exists so brings it to the focus

    figure(figPtr);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% DEBUG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if debug
        clc %#ok<UNRCH>
        close(figPtr);
        GUI.VIEW.OpenGUI();
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


else % Create the figure

    rng('default')
    rng('shuffle')

    % Create a figure
    figHandle = figure( ...
        'HandleVisibility', 'off',... % close all does not close the figure
        'MenuBar'         , 'none'                   , ...
        'Toolbar'         , 'none'                   , ...
        'Name'            , gui_name                 , ...
        'NumberTitle'     , 'off'                    , ...
        'Units'           , 'Pixels'                 , ...
        'Position'        , [50, 50, 600, 800]       , ...
        'Tag'             , gui_name                 );

    figureBGcolor = [0.9 0.9 0.9]; set(figHandle,'Color',figureBGcolor);
    buttonBGcolor = figureBGcolor - 0.1;
    editBGcolor   = [1.0 1.0 1.0];

    % Create GUI handles : pointers to access the graphic objects
    handles               = guihandles(figHandle);
    handles.figureBGcolor = figureBGcolor;
    handles.buttonBGcolor = buttonBGcolor;
    handles.editBGcolor   = editBGcolor  ;


    %% Panel proportions

    % relative proportions of each panel, from bottom to top
    PANEL = GUI.VIEW.PanelDispatcher( [0.50 0.50 1.50 0.50 1 0.50 0.50 0.50 1.0 ] );


    %% Panel : Subject & Run

    p_sr.x = PANEL.x_pos;
    p_sr.w = PANEL.x_width;

    PANEL.next();
    p_sr.y = PANEL.y_pos;
    p_sr.h = PANEL.y_height;

    handles.uipanel_SubjectRun = uipanel(handles.(gui_name),...
        'Title','Subject & Run',...
        'Units', 'Normalized',...
        'Position',[p_sr.x p_sr.y p_sr.w p_sr.h],...
        'BackgroundColor',figureBGcolor);

    o_sr = GUI.VIEW.ObjectDispatcher( [1 1 1] );
    p_sr.yposOmain = 0.1;
    p_sr.hOmain    = 0.6;
    p_sr.yposOhdr  = 0.7;
    p_sr.hOhdr     = 0.2;


    % ---------------------------------------------------------------------
    % Edit : Subject ID

    o_sr.next();
    e_sid.x = o_sr.xpos;
    e_sid.y = p_sr.yposOmain ;
    e_sid.w = o_sr.xwidth;
    e_sid.h = p_sr.hOmain;
    handles.edit_SubjectID = uicontrol(handles.uipanel_SubjectRun,...
        'Style','edit',...
        'Units', 'Normalized',...
        'Position',[e_sid.x e_sid.y e_sid.w e_sid.h],...
        'BackgroundColor',editBGcolor,...
        'String','',...
        'Callback',@GUI.VIEW.Callback.edit_SubjectID);


    % ---------------------------------------------------------------------
    % Text : Subject ID

    t_sid.x = o_sr.xpos;
    t_sid.y = p_sr.yposOhdr ;
    t_sid.w = o_sr.xwidth;
    t_sid.h = p_sr.hOhdr;
    handles.text_SubjectID = uicontrol(handles.uipanel_SubjectRun,...
        'Style','text',...
        'Units', 'Normalized',...
        'Position',[t_sid.x t_sid.y t_sid.w t_sid.h],...
        'String','Subject ID',...
        'BackgroundColor',figureBGcolor);


    % ---------------------------------------------------------------------
    % Pushbutton : Check SubjectID data

    o_sr.next();
    b_csidd.x = o_sr.xpos;
    b_csidd.y = p_sr.yposOmain;
    b_csidd.w = o_sr.xwidth;
    b_csidd.h = p_sr.hOmain;
    handles.pushbutton_Check_SubjectID_data = uicontrol(handles.uipanel_SubjectRun,...
        'Style','pushbutton',...
        'Units', 'Normalized',...
        'Position',[b_csidd.x b_csidd.y b_csidd.w b_csidd.h],...
        'String','Check SubjectID data',...
        'BackgroundColor',buttonBGcolor,...
        'TooltipString','Display in Command Window the content of data/(SubjectID)',...
        'Callback',@GUI.VIEW.Callback.pushbutton_CheckSubjecIDdata);


    % ---------------------------------------------------------------------
    % Text : Last file name annoucer

    o_sr.next();
    t_lfna.x = o_sr.xpos;
    t_lfna.y = p_sr.yposOhdr ;
    t_lfna.w = o_sr.xwidth;
    t_lfna.h = p_sr.hOhdr;
    handles.text_LastFileNameAnnouncer = uicontrol(handles.uipanel_SubjectRun,...
        'Style','text',...
        'Units', 'Normalized',...
        'Position',[t_lfna.x t_lfna.y t_lfna.w t_lfna.h],...
        'String','Last file name',...
        'BackgroundColor',figureBGcolor,...
        'Visible','Off');


    % ---------------------------------------------------------------------
    % Text : Last file name

    t_lfn.x = o_sr.xpos;
    t_lfn.y = p_sr.yposOmain ;
    t_lfn.w = o_sr.xwidth;
    t_lfn.h = p_sr.hOmain;
    handles.text_LastFileName = uicontrol(handles.uipanel_SubjectRun,...
        'Style','text',...
        'Units', 'Normalized',...
        'Position',[t_lfn.x t_lfn.y t_lfn.w t_lfn.h],...
        'String','',...
        'BackgroundColor',figureBGcolor,...
        'Visible','Off');


    %% Panel : Save mode

    p_sm.x = PANEL.x_pos;
    p_sm.w = PANEL.x_width;

    PANEL.next();
    p_sm.y = PANEL.y_pos;
    p_sm.h = PANEL.y_height;

    handles.uipanel_SaveMode = uibuttongroup(handles.(gui_name),...
        'Title','Save mode',...
        'Units', 'Normalized',...
        'Position',[p_sm.x p_sm.y p_sm.w p_sm.h],...
        'BackgroundColor',figureBGcolor);

    o_sm = GUI.VIEW.ObjectDispatcher( [1 1] , 0.20 );

    % ---------------------------------------------------------------------
    % RadioButton : Save Data

    o_sm.next();
    r_sd.x   = o_sm.xpos;
    r_sd.y   = 0.1 ;
    r_sd.w   = p_sm.w;
    r_sd.h   = 0.8;
    r_sd.tag = 'radiobutton_Save_1';
    handles.(r_sd.tag) = uicontrol(handles.uipanel_SaveMode,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_sd.x r_sd.y r_sd.w r_sd.h],...
        'String','Save data',...
        'TooltipString','Save data to : ../data/SubjectID/...',...
        'HorizontalAlignment','Center',...
        'Tag',r_sd.tag,...
        'BackgroundColor',figureBGcolor);


    % ---------------------------------------------------------------------
    % RadioButton : No save

    o_sm.next();
    r_ns.x   = o_sm.xpos;
    r_ns.y   = 0.1 ;
    r_ns.w   = p_sm.w;
    r_ns.h   = 0.8;
    r_ns.tag = 'radiobutton_Save_0';
    handles.(r_ns.tag) = uicontrol(handles.uipanel_SaveMode,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_ns.x r_ns.y r_ns.w r_ns.h],...
        'String','No save',...
        'TooltipString','In Acquisition mode, Save mode must be engaged',...
        'HorizontalAlignment','Center',...
        'Tag',r_ns.tag,...
        'BackgroundColor',figureBGcolor);


    %% Panel : Input method

    p_input.x = PANEL.x_pos;
    p_input.w = PANEL.x_width;

    PANEL.next();
    p_input.y = PANEL.y_pos;
    p_input.h = PANEL.y_height;

    handles.uipanel_InputMethod = uibuttongroup(handles.(gui_name),...
        'Title','Input method',...
        'Units', 'Normalized',...
        'Position',[p_input.x p_input.y p_input.w p_input.h],...
        'BackgroundColor',figureBGcolor,...
        'SelectionChangedFcn',@GUI.VIEW.SelectionChangeFcn.uipanel_InputMethod);

    o_input = GUI.VIEW.ObjectDispatcher( [1 1] , 0.20 );

    % ---------------------------------------------------------------------
    % RadioButton : Eyetracker

    o_input.next();
    r_eye.x   = o_input.xpos;
    r_eye.y   = 0.1 ;
    r_eye.w   = o_input.xwidth;
    r_eye.h   = 0.8;
    r_eye.tag = 'radiobutton_input_eyetracker';
    handles.(r_eye.tag) = uicontrol(handles.uipanel_InputMethod,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_eye.x r_eye.y r_eye.w r_eye.h],...
        'String','Eyetracker',...
        'HorizontalAlignment','Center',...
        'Tag',r_eye.tag,...
        'BackgroundColor',figureBGcolor);


    % ---------------------------------------------------------------------
    % RadioButton : Mouse

    o_input.next();
    r_mouse.x   = o_input.xpos;
    r_mouse.y   = 0.1 ;
    r_mouse.w   = o_input.xwidth;
    r_mouse.h   = 0.8;
    r_mouse.tag = 'radiobutton_input_mouse';
    handles.(r_mouse.tag) = uicontrol(handles.uipanel_InputMethod,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_mouse.x r_mouse.y r_mouse.w r_mouse.h],...
        'String','Mouse',...
        'HorizontalAlignment','Center',...
        'Tag',r_mouse.tag,...
        'BackgroundColor',figureBGcolor);


    %% Panel : Show gaze, yes or no ?

    p_show.x = PANEL.x_pos;
    p_show.w = PANEL.x_width;

    PANEL.next();
    p_show.y = PANEL.y_pos;
    p_show.h = PANEL.y_height;

    handles.uipanel_ShowGaze = uibuttongroup(handles.(gui_name),...
        'Title','Show cursor',...
        'Units', 'Normalized',...
        'Position',[p_show.x p_show.y p_show.w p_show.h],...
        'BackgroundColor',figureBGcolor);

    o_gaze = GUI.VIEW.ObjectDispatcher( [1 1] , 0.20 );

    % ---------------------------------------------------------------------
    % RadioButton : show::no

    o_gaze.next();
    r_show_no.x   = o_gaze.xpos;
    r_show_no.y   = 0.1 ;
    r_show_no.w   = o_gaze.xwidth;
    r_show_no.h   = 0.8;
    r_show_no.tag = 'radiobutton_show_0';
    handles.(r_show_no.tag) = uicontrol(handles.uipanel_ShowGaze,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_show_no.x r_show_no.y r_show_no.w r_show_no.h],...
        'String','No',...
        'HorizontalAlignment','Center',...
        'Tag',r_show_no.tag,...
        'BackgroundColor',figureBGcolor);


    % ---------------------------------------------------------------------
    % RadioButton : show::yes

    o_gaze.next();
    r_show_yes.x   = o_gaze.xpos;
    r_show_yes.y   = 0.1 ;
    r_show_yes.w   = o_gaze.xwidth;
    r_show_yes.h   = 0.8;
    r_show_yes.tag = 'radiobutton_show_1';
    handles.(r_show_yes.tag) = uicontrol(handles.uipanel_ShowGaze,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_show_yes.x r_show_yes.y r_show_yes.w r_show_yes.h],...
        'String','Yes',...
        'HorizontalAlignment','Center',...
        'Tag',r_show_yes.tag,...
        'BackgroundColor',figureBGcolor);


    %% Panel : Eyelink mode

    el_shift = 0.25;

    p_el.x = PANEL.x_pos/2 + el_shift;
    p_el.w = PANEL.x_width - el_shift + PANEL.x_pos/2;

    PANEL.next();
    p_el.y = PANEL.y_pos;
    p_el.h = PANEL.y_height;

    handles.uipanel_EyelinkMode = uibuttongroup(handles.(gui_name),...
        'Title','Eyelink mode',...
        'Units', 'Normalized',...
        'Position',[p_el.x p_el.y p_el.w p_el.h],...
        'BackgroundColor',figureBGcolor,...
        'SelectionChangeFcn',@GUI.VIEW.SelectionChangeFcn.uipanel_EyelinkMode);


    % ---------------------------------------------------------------------
    % Checkbox : Windowed screen

    c_ws.x = PANEL.x_pos;
    c_ws.w = el_shift - PANEL.x_pos/2;

    c_ws.y = PANEL.y_pos-0.01 ;
    c_ws.h = p_el.h * 0.3;

    handles.checkbox_WindowedScreen = uicontrol(handles.(gui_name),...
        'Style','checkbox',...
        'Units', 'Normalized',...
        'Position',[c_ws.x c_ws.y c_ws.w c_ws.h],...
        'String','Windowed screen',...
        'HorizontalAlignment','Center',...
        'BackgroundColor',figureBGcolor);


    % ---------------------------------------------------------------------
    % Listbox : Screens

    l_sc.x = PANEL.x_pos;
    l_sc.w = el_shift - PANEL.x_pos;

    l_sc.y = c_ws.y + c_ws.h ;
    l_sc.h = p_el.h * 0.6;

    handles.listbox_Screens = uicontrol(handles.(gui_name),...
        'Style','listbox',...
        'Units', 'Normalized',...
        'Position',[l_sc.x l_sc.y l_sc.w l_sc.h],...
        'String',{'a' 'b' 'c'},...
        'TooltipString','Select the display mode   PTB : 0 for extended display (over all screens) , 1 for screen 1 , 2 for screen 2 , etc.',...
        'HorizontalAlignment','Center',...
        'CreateFcn',@GUI.Listbox_Screens_CreateFcn);


    % ---------------------------------------------------------------------
    % Text : ScreenMode

    t_sm.x = PANEL.x_pos;
    t_sm.w = el_shift - PANEL.x_pos;

    t_sm.y = l_sc.y + l_sc.h ;
    t_sm.h = p_el.h * 0.15;

    handles.text_ScreenMode = uicontrol(handles.(gui_name),...
        'Style','text',...
        'Units', 'Normalized',...
        'Position',[t_sm.x t_sm.y t_sm.w t_sm.h],...
        'String','Screen mode selection',...
        'TooltipString','Output of Screen(''Screens'')   Use ''Screen Screens?'' in Command window for help',...
        'HorizontalAlignment','Center',...
        'BackgroundColor',figureBGcolor);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    p_el_up.nbO    = 6; % Number of objects
    p_el_up.w     = 1/(p_el_up.nbO + 1); % Object width
    p_el_up.count = 0; % Object counter
    p_el_up.xpos  = @(count) p_el_up.w/(p_el_up.nbO+1)*count + (count-1)*p_el_up.w;
    p_el_up.y      = 0.6;
    p_el_up.h      = 0.3;

    % ---------------------------------------------------------------------
    % RadioButton : Eyelink ON

    p_el_up.count = p_el_up.count + 1;
    r_elon.x   = p_el_up.xpos(p_el_up.count);
    r_elon.y   = p_el_up.y ;
    r_elon.w   = p_el_up.w;
    r_elon.h   = p_el_up.h;
    r_elon.tag = 'radiobutton_Eyelink_1';
    handles.(r_elon.tag) = uicontrol(handles.uipanel_EyelinkMode,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_elon.x r_elon.y r_elon.w r_elon.h],...
        'String','On',...
        'HorizontalAlignment','Center',...
        'Tag',r_elon.tag,...
        'BackgroundColor',figureBGcolor,...
        'Visible','On');


    % ---------------------------------------------------------------------
    % RadioButton : Eyelink OFF

    p_el_up.count = p_el_up.count + 1;
    r_eloff.x   = p_el_up.xpos(p_el_up.count);
    r_eloff.y   = p_el_up.y ;
    r_eloff.w   = p_el_up.w;
    r_eloff.h   = p_el_up.h;
    r_eloff.tag = 'radiobutton_Eyelink_0';
    handles.(r_eloff.tag) = uicontrol(handles.uipanel_EyelinkMode,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_eloff.x r_eloff.y r_eloff.w r_eloff.h],...
        'String','Off',...
        'HorizontalAlignment','Center',...
        'Tag',r_eloff.tag,...
        'BackgroundColor',figureBGcolor,...
        'Visible','On');


    % ---------------------------------------------------------------------
    % Checkbox : Parallel port

    p_el_up.count = p_el_up.count + 1;
    c_pp.x = p_el_up.xpos(p_el_up.count);
    c_pp.y = p_el_up.y ;
    c_pp.w = p_el_up.w*2;
    c_pp.h = p_el_up.h;
    handles.checkbox_ParPort = uicontrol(handles.uipanel_EyelinkMode,...
        'Style','checkbox',...
        'Units', 'Normalized',...
        'Position',[c_pp.x c_pp.y c_pp.w c_pp.h],...
        'String','Parallel port',...
        'HorizontalAlignment','Center',...
        'TooltipString','Send messages via parallel port : useful for Eyelink',...
        'BackgroundColor',figureBGcolor,...
        'Value',0,...
        'Callback',@GUI.Checkbox_ParPort_Callback,...
        'CreateFcn',@GUI.Checkbox_ParPort_Callback,...
        'Visible','On');


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    p_el_dw.nbO    = 4.5; % Number of objects
    p_el_dw.w     = 1/(p_el_dw.nbO + 1); % Object width
    p_el_dw.count = 0; % Object counter
    p_el_dw.xpos  = @(count) p_el_dw.w/(p_el_dw.nbO+1)*count + (count-1)*p_el_dw.w;
    p_el_dw.y      = 0.1;
    p_el_dw.h      = 0.4 ;


    % ---------------------------------------------------------------------
    % Pushbutton : Eyelink Initialize

    p_el_dw.count = p_el_dw.count + 1;
    b_init.x = p_el_dw.xpos(p_el_dw.count);
    b_init.y = p_el_dw.y ;
    b_init.w = p_el_dw.w;
    b_init.h = p_el_dw.h;
    handles.pushbutton_Initialize = uicontrol(handles.uipanel_EyelinkMode,...
        'Style','pushbutton',...
        'Units', 'Normalized',...
        'Position',[b_init.x b_init.y b_init.w b_init.h],...
        'String','Initialize',...
        'BackgroundColor',buttonBGcolor,...
        'Callback','Eyelink.Initialize');

    % ---------------------------------------------------------------------
    % Pushbutton : Eyelink IsConnected

    p_el_dw.count = p_el_dw.count + 1;
    b_isco.x = p_el_dw.xpos(p_el_dw.count);
    b_isco.y = p_el_dw.y ;
    b_isco.w = p_el_dw.w;
    b_isco.h = p_el_dw.h;
    handles.pushbutton_IsConnected = uicontrol(handles.uipanel_EyelinkMode,...
        'Style','pushbutton',...
        'Units', 'Normalized',...
        'Position',[b_isco.x b_isco.y b_isco.w b_isco.h],...
        'String','IsConnected',...
        'BackgroundColor',buttonBGcolor,...
        'Callback','Eyelink.IsConnected');


    % ---------------------------------------------------------------------
    % Pushbutton : Eyelink Calibration

    p_el_dw.count = p_el_dw.count + 1;
    b_cal.x   = p_el_dw.xpos(p_el_dw.count);
    b_cal.y   = p_el_dw.y ;
    b_cal.w   = p_el_dw.w;
    b_cal.h   = p_el_dw.h;
    b_cal.tag = 'pushbutton_EyelinkCalibration';
    handles.(b_cal.tag) = uicontrol(handles.uipanel_EyelinkMode,...
        'Style','pushbutton',...
        'Units', 'Normalized',...
        'Position',[b_cal.x b_cal.y b_cal.w b_cal.h],...
        'String','Calibration',...
        'BackgroundColor',buttonBGcolor,...
        'Tag',b_cal.tag,...
        'Callback',@GUI.VIEW.Callback.pushbutton_EyelinkCalibration);


    % ---------------------------------------------------------------------
    % Pushbutton : Download EL files according to the SubjectID

    p_el_dw.count = p_el_dw.count + 1;
    b_cal.x   = p_el_dw.xpos(p_el_dw.count);
    b_cal.y   = p_el_dw.y ;
    b_cal.w   = p_el_dw.w*1.5;
    b_cal.h   = p_el_dw.h;
    b_cal.tag = 'pushbutton_DownloadELfiles';
    handles.(b_cal.tag) = uicontrol(handles.uipanel_EyelinkMode,...
        'Style','pushbutton',...
        'Units', 'Normalized',...
        'Position',[b_cal.x b_cal.y b_cal.w b_cal.h],...
        'String','Download files',...
        'BackgroundColor',buttonBGcolor*0.9,...
        'Tag',b_cal.tag,...
        'Callback',@GUI.VIEW.Callback.pushbutton_DownloadELfiles);


    % ---------------------------------------------------------------------
    % Pushbutton : Eyelink force shutdown

    b_fsd.x = c_pp.x + c_pp.h;
    b_fsd.y = p_el_up.y ;
    b_fsd.w = p_el_dw.w*1.50;
    b_fsd.h = p_el_dw.h;
    handles.pushbutton_ForceShutDown = uicontrol(handles.uipanel_EyelinkMode,...
        'Style','pushbutton',...
        'Units', 'Normalized',...
        'Position',[b_fsd.x b_fsd.y b_fsd.w b_fsd.h],...
        'String','ForceShutDown',...
        'BackgroundColor',buttonBGcolor,...
        'Callback','Eyelink.ForceShutDown');


    %% Panel : training vs. full

    p_dur.x = PANEL.x_pos;
    p_dur.w = PANEL.x_width;

    %----------------------------------------------------------------------
    %

    PANEL.next();
    p_dur.y = PANEL.y_pos;
    p_dur.h = PANEL.y_height;

    handles.uipanel_Duration = uibuttongroup(handles.(gui_name),...
        'Title','Training vs. full',...
        'Units', 'Normalized',...
        'Position',[p_dur.x p_dur.y p_dur.w p_dur.h],...
        'BackgroundColor',figureBGcolor);


    o_dur = GUI.VIEW.ObjectDispatcher( [1 1] , 0.20 );

    % ---------------------------------------------------------------------
    % RadioButton : Eyetracker

    o_dur.next();
    r_training.x   = o_dur.xpos;
    r_training.y   = 0.1 ;
    r_training.w   = o_dur.xwidth;
    r_training.h   = 0.8;
    r_training.tag = 'radiobutton_duration_training';
    handles.(r_training.tag) = uicontrol(handles.uipanel_Duration,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_training.x r_training.y r_training.w r_training.h],...
        'String','Training',...
        'HorizontalAlignment','Center',...
        'Tag',r_training.tag,...
        'BackgroundColor',figureBGcolor);


    % ---------------------------------------------------------------------
    % RadioButton : Mouse

    o_dur.next();
    r_full.x   = o_dur.xpos;
    r_full.y   = 0.1 ;
    r_full.w   = o_dur.xwidth;
    r_full.h   = 0.8;
    r_full.tag = 'radiobutton_duration_full';
    handles.(r_full.tag) = uicontrol(handles.uipanel_Duration,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_full.x r_full.y r_full.w r_full.h],...
        'String','Full',...
        'HorizontalAlignment','Center',...
        'Tag',r_full.tag,...
        'BackgroundColor',figureBGcolor);


    %% Panel : Task

    p_task.x = PANEL.x_pos;
    p_task.w = PANEL.x_width ;

    %----------------------------------------------------------------------
    %

    PANEL.next();
    p_task.y = PANEL.y_pos;
    p_task.h = PANEL.y_height;

    handles.uipanel_Task = uibuttongroup(handles.(gui_name),...
        'Title','Task',...
        'Units', 'Normalized',...
        'Position',[p_task.x p_task.y p_task.w p_task.h],...
        'BackgroundColor',figureBGcolor);

    % Reward

    b_task.x   = 0.05;
    b_task.w   = 0.40;
    b_task.y   = 0.05;
    b_task.h   = 0.20;
    b_task.tag = 'pushbutton_Reward__Incongruent_Right';
    b_task.name = 'Reward : Incongruent + Right';
    addTask(handles, b_task)

    b_task.x   = 0.55;
    b_task.w   = 0.40;
    b_task.y   = 0.05;
    b_task.h   = 0.20;
    b_task.tag = 'pushbutton_Reward__Incongruent_Down';
    b_task.name = 'Reward : Incongruent + Down';
    addTask(handles, b_task)

    b_task.x   = 0.05;
    b_task.w   = 0.40;
    b_task.y   = 0.30;
    b_task.h   = 0.20;
    b_task.tag = 'pushbutton_Reward__Congruent_Right';
    b_task.name = 'Reward : Congruent + Right';
    addTask(handles, b_task)

    b_task.x   = 0.55;
    b_task.w   = 0.40;
    b_task.y   = 0.30;
    b_task.h   = 0.20;
    b_task.tag = 'pushbutton_Reward__Congruent_Down';
    b_task.name = 'Reward : Congruent + Down';
    addTask(handles, b_task)


    % GoNogo

    b_task.x   = 0.05;
    b_task.w   = 0.90;
    b_task.y   = 0.55;
    b_task.h   = 0.35;
    b_task.tag = 'pushbutton_GoNogo';
    b_task.name = 'GoNogo';
    addTask(handles, b_task)


    %% Panel : Operation mode

    p_op.x = PANEL.x_pos;
    p_op.w = PANEL.x_width;

    PANEL.next();
    p_op.y = PANEL.y_pos;
    p_op.h = PANEL.y_height;

    handles.uipanel_OperationMode = uibuttongroup(handles.(gui_name),...
        'Title','Operation mode',...
        'Units', 'Normalized',...
        'Position',[p_op.x p_op.y p_op.w p_op.h],...
        'BackgroundColor',figureBGcolor);

    o_op = GUI.VIEW.ObjectDispatcher( [1 1 1] , 0.1 );

    % ---------------------------------------------------------------------
    % RadioButton : Acquisition

    o_op.next()
    r_aq.x = o_op.xpos;
    r_aq.y = 0.1 ;
    r_aq.w = p_op.w;
    r_aq.h = 0.8;
    r_aq.tag = 'radiobutton_Acquisition';
    handles.(r_aq.tag) = uicontrol(handles.uipanel_OperationMode,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_aq.x r_aq.y r_aq.w r_aq.h],...
        'String','Acquisition',...
        'TooltipString','Save data, execute full script',...
        'HorizontalAlignment','Center',...
        'Tag',r_aq.tag,...
        'BackgroundColor',figureBGcolor);


    % ---------------------------------------------------------------------
    % RadioButton : FastDebug

    o_op.next()
    r_fd.x   = o_op.xpos;
    r_fd.y   = 0.1 ;
    r_fd.w   = p_op.w;
    r_fd.h   = 0.8;
    r_fd.tag = 'radiobutton_FastDebug';
    handles.radiobutton_FastDebug = uicontrol(handles.uipanel_OperationMode,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_fd.x r_fd.y r_fd.w r_fd.h],...
        'String','FastDebug',...
        'TooltipString','Don''t save data, run the scripts very fast',...
        'HorizontalAlignment','Center',...
        'Tag',r_fd.tag,...
        'BackgroundColor',figureBGcolor);


    % ---------------------------------------------------------------------
    % RadioButton : RealisticDebug

    o_op.next()
    r_rd.x   = o_op.xpos;
    r_rd.y   = 0.1 ;
    r_rd.w   = p_op.w;
    r_rd.h   = 0.8;
    r_rd.tag = 'radiobutton_RealisticDebug';
    handles.(r_rd.tag) = uicontrol(handles.uipanel_OperationMode,...
        'Style','radiobutton',...
        'Units', 'Normalized',...
        'Position',[r_rd.x r_rd.y r_rd.w r_rd.h],...
        'String','RealisticDebug',...
        'TooltipString','ODon''t save data, run the scripts ~normal speed',...
        'HorizontalAlignment','Center',...
        'Tag',r_rd.tag,...
        'BackgroundColor',figureBGcolor);


    %% Panel : record movie

    p_movie.x = PANEL.x_pos;
    p_movie.w = PANEL.x_width;

    PANEL.next();
    p_movie.y = PANEL.y_pos;
    p_movie.h = PANEL.y_height;

    handles.uipanel_Movie = uibuttongroup(handles.(gui_name),...
        'Title','Movie recording',...
        'Units', 'Normalized',...
        'Position',[p_movie.x p_movie.y p_movie.w p_movie.h],...
        'BackgroundColor',figureBGcolor);

    o_movie = GUI.VIEW.ObjectDispatcher( [1 1] , 0.25 );

    % ---------------------------------------------------------------------
    % RadioButton : 0

    o_movie.next();
    r_movie_off.x   = o_movie.xpos;
    r_movie_off.y   = 0.1 ;
    r_movie_off.w   = p_movie.w;
    r_movie_off.h   = 0.8;
    r_movie_off.tag = 'radiobutton_movie_0';
    handles.(r_movie_off.tag) = uicontrol(handles.uipanel_Movie,...
        'Style','radiobutton'                             ,...
        'Units', 'Normalized'                             ,...
        'Position',[r_movie_off.x r_movie_off.y r_movie_off.w r_movie_off.h],...
        'String','Off       '                             ,...
        'HorizontalAlignment','Center'                    ,...
        'Tag',r_movie_off.tag                             ,...
        'BackgroundColor',figureBGcolor                   );


    % ---------------------------------------------------------------------
    % RadioButton : 1

    o_movie.next();
    r_movie_on.x   = o_movie.xpos;
    r_movie_on.y   = 0.1 ;
    r_movie_on.w   = p_movie.w;
    r_movie_on.h   = 0.8;
    r_movie_on.tag = 'radiobutton_movie_1';
    handles.(r_movie_on.tag) = uicontrol(handles.uipanel_Movie,...
        'Style','radiobutton'                               ,...
        'Units', 'Normalized'                               ,...
        'Position',[r_movie_on.x r_movie_on.y r_movie_on.w r_movie_on.h],...
        'String','On'                                       ,...
        'HorizontalAlignment','Center'                      ,...
        'Tag',r_movie_on.tag                                ,...
        'BackgroundColor',figureBGcolor                     );


    %% End of opening

    % IMPORTANT
    guidata(figHandle,handles)
    % After creating the figure, dont forget the line
    % guidata(figHandle,handles) . It allows smart retrive like
    % handles=guidata(hObject)

    % Init with EYELINK On
    set(handles.uipanel_EyelinkMode,'SelectedObject',handles.radiobutton_Eyelink_1)
    eventdata.NewValue = handles.radiobutton_Eyelink_1;
    GUI.VIEW.SelectionChangeFcn.uipanel_EyelinkMode(handles.uipanel_EyelinkMode, eventdata)


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% DEBUG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if debug
        assignin('base','handles',handles) %#ok<UNRCH>
        disp(handles)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    figPtr = figHandle;

    fprintf('\n')
    fprintf('Response buttons (fORRP 932) : \n')
    fprintf('USB \n')
    fprintf('HHSC - 2x1 CYL \n')
    fprintf('HID BYGRT \n')
    fprintf('\n')


end % creation of figure

if nargout > 0

    varargout{1} = guidata(figPtr);

end


end % function


function handles = addTask(handles, b_task)

handles.(b_task.tag) = uicontrol(handles.uipanel_Task       ,...
    'Style'          , 'pushbutton'                         ,...
    'Units'          , 'Normalized'                         ,...
    'Position'       , [b_task.x b_task.y b_task.w b_task.h],...
    'String'         ,  b_task.name                         ,...
    'BackgroundColor', handles.buttonBGcolor                        ,...
    'Tag'            , b_task.tag                           ,...
    'Callback'       , @GUI.MODEL.Core                      );
end

