classdef WALL_E < PTB_OBJECTS.VIDEO.Base


    %% Properties

    properties

        % Parameters
        
        dim           (1,1) double  % size of rect, in VA
        width         (1,1) double  % width of rect, in VA
        center        (1,2) double  % [ CenterX CenterY ] ratio from 0 to 1 ofscreen size

        color         (1,1) struct = struct( ...
            'white' , [255 255 255 255], ...
            'yellow', [255 255 000 255], ...
            'green' , [000 255 000 255], ...
            'red'   , [255 000 000 255]  ...
            )

        % Internal variables

        frameRect     (1,4) double  % [x1 y1 x2 y2] pixels, PTB coordinates
        frameWidth    (1,1) double  % pixels
        
        img           (1,1) struct = struct( ...
            'free' , [], ...
            'right', [], ...
            'left' , [], ...
            'up'   , [], ...
            'down' , []  ...
            )

    end % properties


    %% Methods

    methods

        % -----------------------------------------------------------------
        %                           Constructor
        % -----------------------------------------------------------------
        % no constructor, easier to manage and just fill the fields

    end % methods

end % classef
