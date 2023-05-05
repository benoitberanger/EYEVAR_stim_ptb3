classdef DOOM < PTB_OBJECTS.VIDEO.Base

    %% Properties

    properties

        % Parameters
        
        font_name (1,:) char
        font_size (1,1) double
        
        color (1,1) struct = struct( ...
            'green', [000 255 000 255], ...
            'white', [255 255 255 255], ...
            'red'  , [255 000 000 255]  ...
            )
        
        % Internal variable
        
        last_reward (1,1) double = 0;
        total       (1,1) double = 0;

        rect (1,4) double
        
    end % properties


    %% Methods

    methods

        % -----------------------------------------------------------------
        %                           Constructor
        % -----------------------------------------------------------------
        % no constructor, easier to manage and just fill the fields

    end % methods


end % class
