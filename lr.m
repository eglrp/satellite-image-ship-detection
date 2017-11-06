function [l] = lr(R)
    % Computes the likelyhood for a region R.
    imgShape = 75*75;
    R_ = reshape(R, [imgShape, 1]);
    [mleR_, ~] = mle(R_);
    stdR = mleR_(1);
    meanR = mleR_(2);
    c = 2*pi;
    
    l = -0.5 * sum(log(c*stdR) + ((R_ - meanR)/stdR));
end