function wall_e = WALL_E()
global S

wall_e = PTB_OBJECTS.VIDEO.WALL_E();
wall_e.LinkToWindowPtr(S.PTB.Video.wPtr);

wall_e.screen_x = S.PTB.Video.wRect(3);
wall_e.screen_y = S.PTB.Video.wRect(4);
wall_e.va2pix   = S.PTB.Video.va2pix;

wall_e.dim    = S.TaskParam.WALL_E.dim;
wall_e.width  = S.TaskParam.WALL_E.width;
wall_e.center = S.TaskParam.WALL_E.center;

wall_e.color.white  = S.TaskParam.WALL_E.color.white;
wall_e.color.yellow = S.TaskParam.WALL_E.color.yellow;
wall_e.color.green  = S.TaskParam.WALL_E.color.green;
wall_e.color.red    = S.TaskParam.WALL_E.color.red;

wall_e.GenRect();

end