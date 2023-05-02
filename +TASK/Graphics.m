function p = Graphics( p )
% Reminder of PTB coordinates : (0,0) is the top left corner
% In (x,y), x is the width  from left to right
%           y is the height from top  to bottom


%% FixationCross (common)

p.FixationCross.dim      = 1.0;                                            % size of cross, in VA
p.FixationCross.width    = 0.10 * p.FixationCross.dim;                     % width of cross arm, in VA
p.FixationCross.color    = [127 127 127 255];                              % [R G B a], from 0 to 255
p.FixationCross.position = [0.50 0.50];                                    % [ CenterX CenterY ] ratio from 0 to 1 ofscreen size


%% WALL_E (common)

p.WALL_E.displaysize    = 1.0;                                             % size of central displayed object, in VA
p.WALL_E.windowsize     = 2.0;                                             % size of central gaze accepted window, in VA
p.WALL_E.width          = 0.10 * p.WALL_E.displaysize;                     % width of rect, in VA
p.WALL_E.center         = [0.50 0.50];                                     % [ CenterX CenterY ] ratio from 0 to 1 ofscreen size


%                         [R   G   B   a  ] from 0 to 255
p.WALL_E.color.white    = [200 200 200 255];
p.WALL_E.color.yellow   = [253 219 000 255];
p.WALL_E.color.green    = [067 182 059 255];
p.WALL_E.color.red      = [220 040 030 255];
p.WALL_E.color.blue     = [112 158 196 255];

p.WALL_E.img.free       = 'img/question_mark_96px.png';
p.WALL_E.img.right      = 'img/arrow_right_96px.png';
p.WALL_E.img.dim        = (p.WALL_E.displaysize - p.WALL_E.width) * 0.9;           % image size, in VA


%% EVE (common)

p.EVE.displaysize       = 1.0;                                             % size of target displayed object, in VA
p.EVE.windowsize        = 2.0;                                             % size of target gaze accepted window, in VA
p.EVE.excentricity_lr   = 10.0;                                            % distance from WALL_E, in VA
p.EVE.excentricity_ud   =  5.0;                                            % distance from WALL_E, in VA
p.EVE.color.yellow      = p.WALL_E.color.yellow;                           % [R G B a] from 0 to 255
p.EVE.img.happy         = 'img/smiley_happy_96px.png';
p.EVE.img.sad           = 'img/smiley_sad_96px.png';


%% SAURON (common)

p.SAURON.dim            = 0.2;                                             % size of rect/cicle, in VA
p.SAURON.color          = [112 158 196 255];                               % [R G B a] from 0 to 255


end % function
