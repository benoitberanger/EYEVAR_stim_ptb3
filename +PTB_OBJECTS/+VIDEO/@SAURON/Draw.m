function Draw(self)

Screen('FillOval', self.wPtr, self.color, CenterRectOnPoint([0 0 self.va2pix*self.dim self.va2pix*self.dim], self.gaze_x, self.gaze_y))

end % function
