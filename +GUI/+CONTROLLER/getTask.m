function [ Task, Congruency, HighRewarded ] = getTask( hObject )

label = strrep( get(hObject,'Tag'), 'pushbutton_', '' );

res1 = strsplit(label, '__');

Task = res1{1};

if numel(res1) > 1

    res2 = strsplit(res1{2}, '_');

    Congruency  = res2{1};
    HighRewarded= res2{2};
    
else
    
    Congruency  = '';
    HighRewarded= '';

end

end % function
