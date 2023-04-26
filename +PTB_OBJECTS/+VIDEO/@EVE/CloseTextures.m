function CloseTextures( self )

images = fieldnames(self.img);
for i = 1 : length(images)
    self.img.(images{i}).CloseTexture();
end

end % function
