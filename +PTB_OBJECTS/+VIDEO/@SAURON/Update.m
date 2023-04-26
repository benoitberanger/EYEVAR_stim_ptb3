function [x,y] = Update(self)

switch self.type
    case 'eyelink'
    case 'mouse'
        [x,y] = GetMouse(self.wPtr);
        self.recorder.AddSample([GetSecs-self.starttime x y NaN]);
    otherwise
        error('input type')
end

self.gaze_x = x;
self.gaze_y = y;

end % function
