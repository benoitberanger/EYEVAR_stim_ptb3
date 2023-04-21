function GenRect(self)

baseRect = [0 0 self.va2pix*self.dim self.va2pix*self.dim];

self.rect.right = CenterRectOnPoint(baseRect, self.center.right(1), self.center.right(2));
self.rect.left  = CenterRectOnPoint(baseRect, self.center.left (1), self.center.left (2));
self.rect.down  = CenterRectOnPoint(baseRect, self.center.down (1), self.center.down (2));
self.rect.up    = CenterRectOnPoint(baseRect, self.center.up   (1), self.center.up   (2));

end
