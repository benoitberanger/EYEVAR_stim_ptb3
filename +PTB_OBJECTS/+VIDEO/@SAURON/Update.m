function [x,y] = Update(self)

switch self.type
    case 'eyetracker'
        sample = Eyelink('NewestFloatSample');
        % 2 is right eye in MOC
        x = sample.gx(2);
        y = sample.gy(2);
        p = sample.pa(2);
        self.recorder.AddSample([GetSecs-self.starttime x y p  ]);
    case 'mouse'
        [x,y] = GetMouse(self.wPtr);
        self.recorder.AddSample([GetSecs-self.starttime x y NaN]);
    otherwise
        error('input type')
end

self.gaze_x = x;
self.gaze_y = y;

end % function
