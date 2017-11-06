% band_1.txt is a file with 75*75*1604=9022500 numbers representing intensities
% measured in dB. That means the file stores 1604 images, of dimensions 75*75.
filename = 'data/band_1.txt';

[M, count] = load_data(filename);
