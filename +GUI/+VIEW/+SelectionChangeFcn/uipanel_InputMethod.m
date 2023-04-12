function uipanel_InputMethod(hObject, eventdata)
handles = guidata(hObject);

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton_input_eyetracker'
        evt.NewValue = handles.radiobutton_Eyelink_1;
    case 'radiobutton_input_mouse'
        evt.NewValue = handles.radiobutton_Eyelink_0;
end

set(handles.uipanel_EyelinkMode,'SelectedObject',evt.NewValue)
GUI.VIEW.SelectionChangeFcn.uipanel_EyelinkMode(handles.uipanel_EyelinkMode, evt)

end % function
