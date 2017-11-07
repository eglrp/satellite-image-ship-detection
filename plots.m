function [] = plots(img)
    figure();
    image(1 - img);
    figure();
    histogram(img);
    figure();
    histogram(1 - img);
end