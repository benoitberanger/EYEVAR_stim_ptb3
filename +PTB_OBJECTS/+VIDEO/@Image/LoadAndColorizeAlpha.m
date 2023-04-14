function LoadAndColorizeAlpha(self, color)

self.Load();

self.X = uint8(cat(3, self.alpha/255*color(1), self.alpha/255*color(2), self.alpha/255*color(3)));

end % function
