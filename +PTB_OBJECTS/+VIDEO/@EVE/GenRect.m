function GenRect(self)

baseRect  = [0 0 self.va2pix*self.displaysize self.va2pix*self.displaysize];
outerRect = [0 0 self.va2pix*self.windowsize  self.va2pix*self.windowsize ];


self.displayRect.right = CenterRectOnPoint(baseRect , self.center.right(1), self.center.right(2));
self.displayRect.left  = CenterRectOnPoint(baseRect , self.center.left (1), self.center.left (2));
self.displayRect.down  = CenterRectOnPoint(baseRect , self.center.down (1), self.center.down (2));
self.displayRect.up    = CenterRectOnPoint(baseRect , self.center.up   (1), self.center.up   (2));

self.windowRect.right  = CenterRectOnPoint(outerRect, self.center.right(1), self.center.right(2));
self.windowRect.left   = CenterRectOnPoint(outerRect, self.center.left (1), self.center.left (2));
self.windowRect.down   = CenterRectOnPoint(outerRect, self.center.down (1), self.center.down (2));
self.windowRect.up     = CenterRectOnPoint(outerRect, self.center.up   (1), self.center.up   (2));

end
