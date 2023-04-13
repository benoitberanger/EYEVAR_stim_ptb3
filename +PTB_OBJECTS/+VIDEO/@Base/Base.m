classdef Base < handle
    % BASE is a 'virtual' class : all subclasses contain this virtual class methods and attributes
    
    properties
        
        wPtr = ''               % Pointer to the PTB screen window
        screen_x  (1,1) double  % number of horizontal pixels of the screen
        screen_y  (1,1) double  % number of vertical   pixels of the screen
        va2pix    (1,1) double  % number of pixel in 1 visual angle
        
    end
    
    methods
        
        % --- Constructor -------------------------------------------------
        % no constructor : this is a 'virtual' object
        % -----------------------------------------------------------------
        
    end
    
end % classdef
