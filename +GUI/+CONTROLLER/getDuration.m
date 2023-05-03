function [ duration ] = getDuration( handles )

radiobutton = get(get(handles.uipanel_Duration,'SelectedObject'),'Tag');

duration = strrep( radiobutton, 'radiobutton_duration_', '' );

end % function
