function [ input ] = getInputMethod( handles )

radiobutton = get(get(handles.uipanel_InputMethod,'SelectedObject'),'Tag');

input = strrep( radiobutton, 'radiobutton_input_', '' );

end % function
