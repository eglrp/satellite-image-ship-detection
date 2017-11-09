function [pd, pfa] = metrics(likelihoodMatrix, labels, threshold)
    % Calculates probability of detection and probability of false alarm
    % based on a matrix of likelihoods for each pixel of images (that is,
    % the matrix has format (512, 512, number of images), a vector
    % with labels (1 - is target, 0 is background) and a threshold.
    %
    % Returns a vector [prob. of detection, prob. of false alarm].

    % PD = ND/NP ( number of detected over number of presented targets).
    % PFA = NFA / (Nimg - NB) (Nimg - number of pixels in the considered
    %   sample, NB - number of pixels of real targets, NFA - number of 
    %   pixels falsely detected as targets).
    aboveThreshold = likelihoodMatrix > threshold;
    s = sum(sum(aboveThreshold, 1));
    aboveThreshold = s ~= 0;
    aboveThreshold = aboveThreshold(:);
    areTarget = labels > 0;
    areTarget = areTarget.';
    
    ND = sum(aboveThreshold & areTarget);
    NP = sum(areTarget);
    pd = ND/NP;
    
    % All images assumed to be 512*512 pixels.
    imgSize = 512 * 512;
    s = size(likelihoodMatrix);
    Nimg = imgSize * s(3);
    % 5*5 targets
    NB = NP * 5 * 5;
    % TODO. Ideally we should only consider 5x5 connected componets that
    % have pixels in the center with higher likelihood, and not all pixels.
    NFA = sum(likelihoodMatrix(:) > threshold);
    pfa = NFA / (Nimg - NB);
end
