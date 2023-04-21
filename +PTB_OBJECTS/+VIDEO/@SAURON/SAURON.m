classdef SAURON < PTB_OBJECTS.VIDEO.Base


    %% Properties

    properties

        % Parameters

        type   (1,:) char                                                  % name of the input method

        % Internal variables

        rec    (1,1) SampleRecorder
        gaze_x (1,1) double
        gaze_y (1,1) double

    end % properties


    %% Methods

    methods

        % -----------------------------------------------------------------
        %                           Constructor
        % -----------------------------------------------------------------
        % no constructor, easier to manage and just fill the fields

    end % methods




end % classef
