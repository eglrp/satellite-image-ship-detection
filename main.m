% band_1.txt is a file with 75*75*1604=9022500 numbers representing intensities
% measured in dB. That means the file stores 1604 images, of dimensions 75*75.
% Leaving it here for history, not really using it anymore.
%filename = 'data/band_1.txt';

targets = ["data/ship1.png", "data/ship2.png", "data/ship3.png", ...
    "data/ship4.png", "data/ship5.png"];

backgrounds = ["data/ocean1.png", "data/ocean2.png"];

window_size = 7;

fprintf('Averaging GLRT for %d targets\n', length(targets));
glrtSum = 0.0;
for imgFilename = targets
    fprintf("Processing file %s\n", imgFilename);
    [img, ~] = imread(char(imgFilename));
    % Flatten color channels into grayscale image.
    img = rgb2gray(img);
    l = glrt(img, window_size);
    glrtSum = glrtSum + l;
end
fprintf("Result: %f\n", glrtSum / length(targets));

fprintf("Averaging GLRT for %d backgrounds\n", length(backgrounds));
glrtSum = 0.0;
for imgFilename = backgrounds
    fprintf("Processing file %s\n", imgFilename);
    [img, ~] = imread(char(imgFilename));
    % Flatten color channels into grayscale image.
    img = rgb2gray(img);
    l = glrt(img, window_size);
    glrtSum = glrtSum + l;
end
fprintf("Result: %f\n", glrtSum / length(backgrounds));
    
%[M, count] = load_data(filename);
