function p = Graphics( p )


%% FixationCross (common)

p.FixationCross.Size     = 0.10;              %  Size_px = ScreenY_px * Size
p.FixationCross.Width    = 0.10;              % Width_px =    Size_px * Width
p.FixationCross.Color    = [127 127 127 255]; % [R G B a], from 0 to 255
p.FixationCross.Position = [0.50 0.50];       % Position_px = [ScreenX_px ScreenY_px] .* Position


%% WALL_E (common)

p.WALL_E.dim            = 1;                                               % size of rect, in VA
p.WALL_E.width          = p.WALL_E.dim * 0.1;                              % width of rect, in VA
p.WALL_E.center         = [0.5 0.5];                                       % [ CenterX CenterY ] ratio from 0 to 1 ofscreen size

%                         [R   G   B   a  ] from 0 to 255
p.WALL_E.color.white    = [200 200 200 255];
p.WALL_E.color.yellow   = [253 219 000 255];
p.WALL_E.color.green    = [067 182 059 255];
p.WALL_E.color.red      = [220 040 030 255];
p.WALL_E.color.blue     = [112 158 196 255];

p.WALL_E.img.free       = 'img/question_mark_96px.png';
p.WALL_E.img.right      = 'img/arrow_right_96px.png';
p.WALL_E.img.dim        = (p.WALL_E.dim - p.WALL_E.width) * 0.9;           % image size, in VA


%% EVE (common)

p.EVE.dim               = p.WALL_E.dim;                                    % size of rect/cicle, in VA
p.EVE.excentricity      = 6;                                               % distance from WALL_E, in VA
p.EVE.color.yellow      = p.WALL_E.color.yellow;                           % [R G B a] from 0 to 255
p.EVE.img.happy         = 'img/smiley_happy_96px.png';
p.EVE.img.sad           = 'img/smiley_sad_96px.png';


end % function
