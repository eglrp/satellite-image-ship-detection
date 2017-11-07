function [ret, l] = glrt(img, window_dim, threshold)
    % Computes the GLRT (Generalized Likelihood Ratio Test) from paper
    % "Characterization of a Bayesian Ship Detection Method in Optical 
    % Satellite Images".
    
    % Computes the logarithm likelihoods of the image given by
    %      NI*m1^2 + N0*m0^2 - NAma^2    (Eq. 6 in the paper)
    % 
    % LA = window_dim * window_dim
    % LI = 5 (kept fixed in the paper)
    % 
    % Pseudo code:
    %   1) For each pixel of the input image:
    %       a) compute the log of the LR as in (6)
    %       b) apply a threshold on the output values
    %       c) postprocess to get rid of multiple positive responses for
    %           each target
    %
    % Parameters:
    %   img - square matrix with image pixels
    imgDim = size(img);
    
    if ndims(img) ~= 2
        error('Matrix must have two dimensions, found: %d', ndims(img));
    end
    
    if imgDim(1) ~= imgDim(2)
        error('Matrix must be square.')
    end
    
    dim = imgDim(1);          
    nPixels = dim * dim;
    ret = false;
    
    l = 0;
    
    for i = 0:nPixels-1
       % Add one as indexing starts at 1.
       x = floor(i / dim) + 1;
       y = mod(i, dim) + 1;
       
       A = get_window(x, y, window_dim, dim);
       [I, O] = get_regions(A);
       % A equals whole image - O.
       new_l = loglr(I, O, A);
      
       % TODO. Right now we are taking the maximum of likelihood values, 
       % is this the best approach?
       l = max(l, new_l); 
    end
    
    ret = l > threshold;
end

function [l] = loglr(I, O, A)
    if ~is_square(I) || ~is_square(O) || ~is_square(A)
        error('Imput matrices must be square.');
    end
    
    % Compute number of pixels inside each region.
    NI = length(I(:));
    NO = length(O(:));
    NA = length(A(:));
    % Compute the mean pixel value inside each region.
    mI = mean(I(:));
    mO = mean(O(:));
    mA = mean(A(:));
    
    l = NI*mI^2 + NO*mO^2 - NA*mA^2;
end