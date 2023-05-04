function eve = EVE(wall_e)
global S

eve = PTB_OBJECTS.VIDEO.EVE();
eve.LinkToWindowPtr(S.PTB.Video.wPtr);
eve.GetScreenSize();

eve.va2pix   = S.PTB.Video.va2pix;

eve.wall_e = wall_e;

eve.displaysize      = S.TaskParam.EVE.displaysize;
eve.windowsize       = S.TaskParam.EVE.windowsize;
eve.excentricity_lr  = S.TaskParam.EVE.excentricity_lr;
eve.excentricity_ud  = S.TaskParam.EVE.excentricity_ud;
eve.color.yellow     = S.TaskParam.EVE.color.yellow;

eve.GenCenter();

eve.img.happy = PTB_OBJECTS.VIDEO.Image();
eve.img.happy.filename = S.TaskParam.EVE.img.happy;
eve.img.happy.LinkToWindowPtr(S.PTB.Video.wPtr);
eve.img.happy.GetScreenSize();
eve.img.happy.LoadAndColorizeAlpha(S.TaskParam.EVE.color.yellow);
eve.img.happy.SmoothAlpha(S.TaskParam.EVE.img.smooth);
eve.img.happy.mask = 'NoMask';
eve.img.happy.scale = eve.va2pix * S.TaskParam.EVE.img.displaysize / eve.img.happy.baseRect(4);
eve.img.happy.MakeTexture();

eve.img.sad = PTB_OBJECTS.VIDEO.Image();
eve.img.sad.filename = S.TaskParam.EVE.img.sad;
eve.img.sad.LinkToWindowPtr(S.PTB.Video.wPtr);
eve.img.sad.GetScreenSize();
eve.img.sad.LoadAndColorizeAlpha(S.TaskParam.EVE.color.yellow);
eve.img.sad.SmoothAlpha(S.TaskParam.EVE.img.smooth);
eve.img.sad.mask = 'NoMask';
eve.img.sad.scale = eve.va2pix * S.TaskParam.EVE.img.displaysize / eve.img.sad.baseRect(4);
eve.img.sad.MakeTexture();

eve.img.neutral = PTB_OBJECTS.VIDEO.Image();
eve.img.neutral.filename = S.TaskParam.EVE.img.neutral;
eve.img.neutral.LinkToWindowPtr(S.PTB.Video.wPtr);
eve.img.neutral.GetScreenSize();
eve.img.neutral.LoadAndColorizeAlpha(S.TaskParam.EVE.color.yellow);
eve.img.neutral.SmoothAlpha(S.TaskParam.EVE.img.smooth);
eve.img.neutral.mask = 'NoMask';
eve.img.neutral.scale = eve.va2pix * S.TaskParam.EVE.img.displaysize / eve.img.neutral.baseRect(4);
eve.img.neutral.MakeTexture();

eve.GenRect();

eve.AssertReady();

end % function
