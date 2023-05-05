function GenRect(self)

txt = sprintf('total = %3d', self.total);

[normBoundsRect, offsetBoundsRect, textHeight, xAdvance] = Screen('TextBounds', self.wPtr, txt);

self.rect = CenterRectOnPoint(normBoundsRect, self.screen_x/2, self.screen_y/2);

end
