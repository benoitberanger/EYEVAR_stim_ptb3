function SmoothAlpha(self, fwhm)

if fwhm

    grid_size       = round(fwhm*2.0);                                                        % the size of the grid must be big enough to sample a gaussian curve
    [grid_x,grid_y] = meshgrid(-grid_size:grid_size, -grid_size:grid_size);                   % create the 2D kernel matrix
    sigma           = fwhm / (2 * sqrt(2*log(2)));                                            % conversion from FWHM to Sigma
    envelope        = 1/(2 * pi * sigma^2) * exp( -(grid_x.^2 + grid_y.^2) / (2 * sigma^2) ); % and here is the 2D gaussian kernel

    alpha = double(self.alpha);
    alpha = conv2( alpha, envelope, 'same' );

    self.alpha = uint8( alpha );

end

end % function
