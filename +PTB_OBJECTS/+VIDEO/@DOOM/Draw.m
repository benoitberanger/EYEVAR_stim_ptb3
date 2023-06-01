function Draw(self, color)

txt1 = sprintf('%+d\n', self.last_reward);
txt2 = sprintf('\ntotal = %3d', self.total);

% [nx, ny, textbounds, wordbounds] = DrawFormattedText(win, tstring, sx, sy, color, wrapat, flipHorizontal, flipVertical, vSpacing, righttoleft, winRect)
DrawFormattedText(self.wPtr, txt1, 'center', 'center', self.color.(color), [], [], [], [], [], self.rect);
DrawFormattedText(self.wPtr, txt2, 'center', 'center', [255,255,255,255], [], [], [], [], [], self.rect);

end