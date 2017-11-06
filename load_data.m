function [A, count] = load_data(filename)
% Reads a txt file containing float numbers.
%
% Returns a 3D matrix 1604, 75*75 images.
    file = fopen(filename, 'r');
    [A, count] = fscanf(file, '%f');
    A = reshape(A, [75, 75, 1604]);
end
