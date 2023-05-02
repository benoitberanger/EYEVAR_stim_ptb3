function DrawImage(self, categ, pos)

switch categ
    case 'happy'
        img = self.img.happy;
    case 'sad'
        img = self.img.sad;
    otherwise
        error('categ')
end

switch pos
    case 'center'
        center = self.center.center;
    case 'right'
        center = self.center.right;
    case 'left'
        center = self.center.left;
    case 'up'
        center = self.center.up;
    case 'down'
        center = self.center.down;
    otherwise
        error('pos')
end

img.Move(center);
img.Draw();

end % function
