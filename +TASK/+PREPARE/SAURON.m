function sauron = SAURON()
global S

sauron = PTB_OBJECTS.VIDEO.SAURON();
sauron.LinkToWindowPtr(S.PTB.Video.wPtr);
sauron.GetScreenSize();

sauron.va2pix   = S.PTB.Video.va2pix;

sauron.type     = S.InputMehtod;

sauron.dim      = S.TaskParam.SAURON.dim;
sauron.color    = S.TaskParam.SAURON.color;

sauron.recorder = SampleRecorder({'t','x','y','p'}, S.EP.Data{end,2} * S.PTB.Video.FPS);

end % function
