classdef EVE < PTB_OBJECTS.VIDEO.Base


    %% Properties

    properties

        % Parameters

        displaysize      (1,1) double  % size of rect/cicle, in VA
        windowsize       (1,1) double  % size of rect/cicle, in VA % edited by varsha
        excentricity_lr  (1,1) double  % distance from WALL_E, in VA
        excentricity_ud  (1,1) double  % distance from WALL_E, in VA

        wall_e           (1,1) PTB_OBJECTS.VIDEO.WALL_E

        color            (1,1) struct = struct( ...
            'yellow', [255 255 000 255] ...
            )

        img              (1,1) struct = struct( ...
            'happy' , [], ...
            'sad'   , []  ...
            )

        % Internal variables

        center           (1,1) struct = struct( ... % [x y] pixels, PTB coordinates
            'center', [], ...
            'right' , [], ...
            'left'  , [], ...
            'up'    , [], ...
            'down'  , []  ...
            )

        displayRect      (1,1) struct = struct( ... % [x1 y1 x2 y2] pixels, PTB coordinates
            'right', [], ...
            'left' , [], ...
            'up'   , [], ...
            'down' , []  ...
            )

        windowRect       (1,1) struct = struct( ... % [x1 y1 x2 y2] pixels, PTB coordinates
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
