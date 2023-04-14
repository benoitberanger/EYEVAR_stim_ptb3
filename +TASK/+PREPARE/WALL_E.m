function wall_e = WALL_E()
global S

wall_e = PTB_OBJECTS.VIDEO.WALL_E();
wall_e.LinkToWindowPtr(S.PTB.Video.wPtr);
wall_e.GetScreenSize();

wall_e.va2pix   = S.PTB.Video.va2pix;

wall_e.dim    = S.TaskParam.WALL_E.dim;
wall_e.width  = S.TaskParam.WALL_E.width;
wall_e.center = S.TaskParam.WALL_E.center;

wall_e.color.white  = S.TaskParam.WALL_E.color.white;
wall_e.color.yellow = S.TaskParam.WALL_E.color.yellow;
wall_e.color.green  = S.TaskParam.WALL_E.color.green;
wall_e.color.red    = S.TaskParam.WALL_E.color.red;

wall_e.GenRect();

wall_e.img.free = PTB_OBJECTS.VIDEO.Image();
wall_e.img.free.filename = S.TaskParam.WALL_E.img.free;
wall_e.img.free.LinkToWindowPtr(S.PTB.Video.wPtr);
wall_e.img.free.GetScreenSize();
wall_e.img.free.LoadAndColorizeAlpha(S.TaskParam.WALL_E.color.blue);
wall_e.img.free.mask = 'NoMask';
wall_e.img.free.MakeTexture();
wall_e.img.free.Move(wall_e.center.*[wall_e.screen_x wall_e.screen_y]);

end
