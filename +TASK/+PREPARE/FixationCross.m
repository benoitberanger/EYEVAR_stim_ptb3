function [ cross ] = FixationCross()
global S

cross        = PTB_OBJECTS.VIDEO.FixationCross();
cross.LinkToWindowPtr(S.PTB.Video.wPtr);
cross.GetScreenSize();

cross.va2pix = S.PTB.Video.va2pix;

cross.dim    = cross.va2pix * S.TaskParam.FixationCross.dim;
cross.width  = cross.va2pix * S.TaskParam.FixationCross.width;
cross.color  = S.TaskParam.FixationCross.color;
cross.center = S.TaskParam.WALL_E.center .* [cross.screen_x cross.screen_y];

cross.GenerateCoords();

cross.AssertReady();

end % function
