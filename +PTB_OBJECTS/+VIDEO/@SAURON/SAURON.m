classdef SAURON < PTB_OBJECTS.VIDEO.Base


    %% Properties

    properties

        % Parameters

        type      (1,:) char                                               % name of the input method

        dim       (1,1) double                                             % size of rect/cicle, in VA
        color     (1,4) uint8                                              % [R G B a] from 0 to 255

        starttime (1,1) double = GetSecs()                                 % PTB timestamp

        % Internal variables

        recorder  (1,1) SampleRecorder

        gaze_x    (1,1) double                                             % last recorded value
        gaze_y    (1,1) double

    end % properties


    %% Methods

    methods

        % -----------------------------------------------------------------
        %                           Constructor
        % -----------------------------------------------------------------
        % no constructor, easier to manage and just fill the fields

    end % methods


end % classef
