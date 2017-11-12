function [R] = extract_window(matrix, window, invert_selection)
   rows = window.row:(window.row + window.height - 1);
   cols = window.col:(window.col + window.width - 1);
   
   if nargin < 3
       invert_selection = false;
   end
   
   if invert_selection
       tmpMatrix = matrix;
       tmpMatrix(rows, cols) = 0;
       R = tmpMatrix(tmpMatrix > 0);     
   else
       R = matrix(rows, cols);
   end
end