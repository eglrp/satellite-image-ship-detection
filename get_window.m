function [window] = get_window(pixel_row, pixel_col, window_side, img_side)
    % Get window centered at pixel, respecting image boundaries.
    %
    % Parameters:
    %   pixel_row - row in the matrix of pixel x coordinate
    %   pixel_col - col in the matrix of pixel x coordinate
    %   window_side - size of the window side (must be an odd number)
    %   img_side - size of the image side
    %
    % Returns:
    %   window struct with attributes:
    %       row - row of the starting position of window
    %       col - column of the starting position of window
    %       width - width of the window
    %       height - height of the window
    
    %if (mod(window_side, 2) == 0)
    %    error('Window must have odd-sized dimensions.');
    %end
    
    %if (window_side > img_side)
    %    error('Window size must be less than or equal to image size.')
    %end
    
    offset = floor(window_side/2); 
    window = struct();
    window.row = min(max(pixel_row - offset, 1), img_side);
    window.col = min(max(pixel_col - offset, 1), img_side);
    pos_col = max(min(pixel_col + offset, img_side), 1);
    window.width = pos_col - window.col + 1;
    pos_row = min(pixel_row + offset, img_side);
    window.height = pos_row - window.row + 1;
end