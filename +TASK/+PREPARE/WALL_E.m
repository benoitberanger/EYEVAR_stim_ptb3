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
wall_e.img.free.scale = wall_e.va2pix * (wall_e.dim - wall_e.width) * 0.9 / wall_e.img.free.baseRect(4);
wall_e.img.free.MakeTexture();
wall_e.img.free.Move(wall_e.center.*[wall_e.screen_x wall_e.screen_y]);

wall_e.img.right = PTB_OBJECTS.VIDEO.Image();
wall_e.img.right.filename = S.TaskParam.WALL_E.img.right;
wall_e.img.right.LinkToWindowPtr(S.PTB.Video.wPtr);
wall_e.img.right.GetScreenSize();
wall_e.img.right.mask = 'NoMask';
wall_e.img.right.LoadAndColorizeAlpha(S.TaskParam.WALL_E.color.yellow);
wall_e.img.right.scale = wall_e.va2pix * (wall_e.dim - wall_e.width) * 0.9 / wall_e.img.right.baseRect(4);
wall_e.img.right.Move(wall_e.center.*[wall_e.screen_x wall_e.screen_y]);

wall_e.img.left       = wall_e.img.right.CopyObject();
wall_e.img.left.X     = rot90(wall_e.img.right.X    ,2);
wall_e.img.left.map   = rot90(wall_e.img.right.map  ,2);
wall_e.img.left.alpha = rot90(wall_e.img.right.alpha,2);

wall_e.img.up         = wall_e.img.right.CopyObject();
wall_e.img.up.X       = rot90(wall_e.img.right.X    ,1);
wall_e.img.up.map     = rot90(wall_e.img.right.map  ,1);
wall_e.img.up.alpha   = rot90(wall_e.img.right.alpha,1);

wall_e.img.down       = wall_e.img.right.CopyObject();
wall_e.img.down.X     = rot90(wall_e.img.right.X    ,3);
wall_e.img.down.map   = rot90(wall_e.img.right.map  ,3);
wall_e.img.down.alpha = rot90(wall_e.img.right.alpha,3);

wall_e.img.right.MakeTexture();
wall_e.img.left .MakeTexture();
wall_e.img.up   .MakeTexture();
wall_e.img.down .MakeTexture();

end
