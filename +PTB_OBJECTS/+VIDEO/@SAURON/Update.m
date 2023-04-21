function [x,y] = Update(self)

switch self.type
    case 'eyelink'
    case 'mouse'
        [x,y] = GetMouse(self.wPtr);
    otherwise
        error('input type')
end

self.recorder.AddSample([GetSecs-self.starttime x y NaN]);
self.gaze_x = x;
self.gaze_y = y;

end % function
