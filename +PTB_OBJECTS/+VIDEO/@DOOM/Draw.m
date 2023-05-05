function Draw(self, color)

txt = sprintf('%+d\ntotal = %3d', ...
    self.last_reward, self.total);

% [nx, ny, textbounds, wordbounds] = DrawFormattedText(win, tstring, sx, sy, color, wrapat, flipHorizontal, flipVertical, vSpacing, righttoleft, winRect)
DrawFormattedText(self.wPtr, txt, 'right', 'center', self.color.(color), [], [], [], [], [], self.rect);

end