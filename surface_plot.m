function [h] = surface_plot(likelihoodMatrix)
    s = size(likelihoodMatrix);
    [X,Y] = meshgrid(1:1:s(1),1:1:s(2));
    h = surf(X, Y, likelihoodMatrix);
    set(h,'LineStyle','none');
end