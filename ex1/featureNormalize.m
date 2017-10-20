function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly
n = size(X,2);
X_norm = X;
mu = zeros(1, n);
sigma = zeros(1, n);

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       

mu = mean(X);
sigma = std(X);
m = size(X,1);
for i=1:m
    for j = 1:n
        X_norm(i,j) = (X(i,j) - mu(j)) / sigma(j);
    endfor
endfor



%fprintf(' x = [%8.4f %8.4f]\n', (X_norm(:,1:2))');
%for i = 1:m
%    fprintf('%6.4f    %6.4f\n', X_norm(i,1), X_norm(i,2));
%endfor
%fprintf('paused');
%pause;









% ============================================================

end
