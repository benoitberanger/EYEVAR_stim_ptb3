function doom = DOOM()
global S

doom = PTB_OBJECTS.VIDEO.DOOM();
doom.LinkToWindowPtr(S.PTB.Video.wPtr);
doom.GetScreenSize();

doom.va2pix   = S.PTB.Video.va2pix;

doom.font_name = S.TaskParam.DOOM.font_name;
doom.font_size = S.TaskParam.DOOM.font_size * doom.va2pix;

doom.GenRect();

doom.AssertReady();
end % function
