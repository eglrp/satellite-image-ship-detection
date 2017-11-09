function [pd, pfa] = metrics(likelihood_matrix, labels, threshold)
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
    aboveThreshold = likelihood_matrix > threshold;
    s = sum(sum(aboveThreshold, 1));
    aboveThreshold = s ~= 0;
    aboveThreshold = aboveThreshold(:);
    areTarget = labels > 0;
    areTarget = areTarget.';
    
    ND = sum(aboveThreshold & areTarget);
    NP = sum(areTarget);
    pd = ND/NP;
    
    % All images assumed to be 512*512 pixels.
    %imgSize = 512 * 512;
    %Nimg = imgSize * length(complete_matrix(:,1));
    %NB = NP * imgSize;
    %NFA = abs(ND-NP) * imgSize;
    %pfa = NFA / (Nimg - NB);
    pfa = 0;
end

