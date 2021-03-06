function [likelihoodMatrix] = glrt(img, window_dim)
    % Computes the Generalized Likelihood Ratio Test for image, given by
    %      NI*m1^2 + N0*m0^2 - NAma^2    (Eq. 6 in the paper)
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
    %   window_dim - length of the window
    imgDim = size(img);
    
    if ndims(img) ~= 2
        error('Matrix must have two dimensions, found: %d', ndims(img));
    end
    
    if imgDim(1) ~= imgDim(2)
        error('Matrix must be square.')
    end
    
    dim = imgDim(1);          
    nPixels = dim * dim;
    
    likelihoodMatrix = zeros(dim);
    
    % Move sliding window throughout the image. At each step one of the
    % pixels in the image will be center of the sliding window.
    for i = 0:nPixels-1
       % Add one as indexing starts at 1.
       x = floor(i / dim) + 1;
       y = mod(i, dim) + 1;
       
       windowA = get_window(x, y, window_dim, dim);
       A = extract_window(img, windowA);
       % Keep target window size fixed.
       dimI = 5;
       windowI = get_window(x, y, dimI, dim);
       I = extract_window(img, windowI);
       O = extract_window(A, windowI, true);
       
       likelihoodMatrix(x, y) = loglr(I, O, A);     
    end
end

function [l] = loglr(I, O, A)
    % Compute log likelihood,
    % H1 - H0 = L(O) + L(I) - L(A) = NI*mI^2 + NO*mO^2 - NA*mA^2
    % Assuming equal variances.
    
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