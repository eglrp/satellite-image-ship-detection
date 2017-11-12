function [img] = read_tiff(filename)
    t = Tiff(filename, 'r');
    img = read(t);
    close(t);
end