% band_1.txt is a file with 75*75*1604=9022500 numbers representing intensities
% measured in dB. That means the file stores 1604 images, of dimensions 75*75.
% Leaving it here for history, not really using it anymore.
%filename = 'data/band_1.txt';

targets = ["data/ship1.png", "data/ship2.png", "data/ship3.png", ...
    "data/ship4.png", "data/ship5.png"];

backgrounds = ["data/ocean1.png", "data/ocean2.png", "data/ocean3.png", ...
    "data/ocean4.png", "data/ocean5.png"];

window_size = 7;

% Assuming pictures are 512*512 pixels.
targetResults = zeros(512);

for imgFilename = targets
    fprintf("Processing file %s\n", imgFilename);
    [img, ~] = imread(char(imgFilename));
    targetResults = cat(3, targetResults, glrt(img, window_size));
end
targetResults = targetResults(:,:,2:6);

% Assuming pictures are 512*512 pixels.
backgroundResults = zeros(512);

for imgFilename = backgrounds
    fprintf("Processing file %s\n", imgFilename);
    [img, ~] = imread(char(imgFilename));
    backgroundResults = cat(3, backgroundResults, glrt(img, window_size));
end
backgroundResults = backgroundResults(:,:,2:6);

