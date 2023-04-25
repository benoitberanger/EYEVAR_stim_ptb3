function GenCenter(self)

[walle_center(1), walle_center(2)] = RectCenter(self.wall_e.frameRect);

self.center.right = walle_center + [+self.va2pix * self.excentricity_lr, 0];
self.center.left  = walle_center + [-self.va2pix * self.excentricity_lr, 0];
self.center.down  = walle_center + [0, +self.va2pix * self.excentricity_ud];
self.center.up    = walle_center + [0, -self.va2pix * self.excentricity_ud];

end % function
