function GenRect(self)

screen_center_px = [self.screen_x self.screen_y] .* self.center;
self.frameRect = CenterRectOnPoint([0 0 1 1] * self.va2pix * self.dim, screen_center_px(1), screen_center_px(2)); 
self.frameWidth = self.width * self.va2pix;

end % function
