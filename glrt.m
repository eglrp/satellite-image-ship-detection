function [ret] = glrt(img, window_dim, threshold)
    % Computes the GLRT (Generalized Likelihood Ratio Test) from paper
    % "Characterization of a Bayesian Ship Detection Method in Optical 
    % Satellite Images".
    
    % Computes the logarithms of the likelihood of the image given by
    % L(H1) - L(H0)*a*NI*m1^2 + N0*m0^2 - NAma^2    (Eq. 6 in the paper)
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
    
    for i = 0:nPixels-1
       % Add one as indexing starts at 1.
       x = floor(i / dim) + 1;
       y = mod(i, dim) + 1;
       
       window = get_window(x, y, window_dim, dim);
       [I, O, A] = get_regions(window);
       l = loglr(I, O, A);
      
       % Right now if we have a positive from any of the pixels we return
       % a dectection. Change this, we need some kind of postprocessing or
       % weighting in order to make a decision.
       if l > threshold
           ret = true;
       end   
    end
    
end

function [l] = loglr(I, O, A)
    % L(H1) = L(I) + L(0)
    L_h1 = lr(I) + lr(O);
    % L(H0) = L(A)
    L_h0 = lr(A);
    
    if ~isSquare(I) || ~isSquare(O) || ~isSquare(A)
        error('Imput matrices must be square.');
    end
    
    tmp = size(I);
    % Compute number of pixels inside each region.
    NI = length(I(:));
    NO = length(O(:));
    NA = length(A(:));
    % Compute the mean pixel value inside each region.
    mI = mean(I(:));
    mO = mean(O(:));
    mA = mean(A(:));
    
    l = L_h1 - L_h0*NI*mI^2 + NO*mO^2 - NA*mA*2;
end

function [b] = isSquare(A)
    % Accepts a two-dimensional matrix A and returns true if A is a square 
    % matrix, otherwise return false.
    dims = ndims(A);
    
    if dims ~= 2:
        error('Expecting matrix with two dimensions, found %d', dims)
    end
    
    sizes = size(A);  
    
    b = sizes(1) == sizes(2);
  
end