function [ show ] = getShow( handles )

radiobutton = get(get(handles.uipanel_ShowGaze,'SelectedObject'),'Tag');

show_str = strrep( radiobutton, 'radiobutton_show_', '' );

show = str2double(show_str);

end % function
