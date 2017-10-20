%% Machine Learning Online Class
%  Exercise 5 | Regularized Linear Regression and Bias-Variance
%
%  Optional exercises
%

%% Initialization
clear ; close all; clc

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  The following code will load the dataset into your environment and plot
%  the data.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

% Load from ex5data1: 
% You will have X, y, Xval, yval, Xtest, ytest in your environment
load ('ex5data1.mat');

% m = Number of examples
m = size(X, 1);

% Plot training data


%% =========== Part 6: Feature Mapping for Polynomial Regression =============
%  One solution to this is to use polynomial regression. You should now
%  complete polyFeatures to map each example into its powers
%

p = 8;

% Map X onto Polynomial Features and Normalize
X_poly = polyFeatures(X, p);
[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
X_poly = [ones(m, 1), X_poly];                   % Add Ones

% Map X_poly_test and normalize (using mu and sigma)
X_poly_test = polyFeatures(Xtest, p);
X_poly_test = bsxfun(@minus, X_poly_test, mu);
X_poly_test = bsxfun(@rdivide, X_poly_test, sigma);
X_poly_test = [ones(size(X_poly_test, 1), 1), X_poly_test];         % Add Ones

% Map X_poly_val and normalize (using mu and sigma)
X_poly_val = polyFeatures(Xval, p);
X_poly_val = bsxfun(@minus, X_poly_val, mu);
X_poly_val = bsxfun(@rdivide, X_poly_val, sigma);
X_poly_val = [ones(size(X_poly_val, 1), 1), X_poly_val];           % Add Ones



lambda = 3;
[theta] = trainLinearReg(X_poly, y, lambda);

[error_train, grad] = linearRegCostFunction( X_poly, y, theta, 0);
[error_test, grad] = linearRegCostFunction( X_poly_test, ytest, theta, 0);	
[error_val, grad] = linearRegCostFunction( X_poly_val, yval, theta, 0);	
fprintf("error_train = %f, error_test = %f, error_val = %f\n",...
	error_train, error_test, error_val);

fprintf('Program paused. Press enter to continue.\n');
pause;


%
% random selection of example
%

error_train = zeros(m, 1);
error_val   = zeros(m, 1);

nrepeat = 50;
lambda = 0.01;
for i=2:12,
    etrain = 0;
    eval = 0;
    for j = 1:nrepeat, % repeat 50 times
	idx = randperm(m);
	theta = trainLinearReg( X_poly(idx(1:i),:), y(idx(1:i)), lambda);
	[etrain, grad] = linearRegCostFunction( X_poly(idx(1:i),:), y(idx(1:i)), theta, 0);
	[eval, grad] = linearRegCostFunction( X_poly_val(idx(1:i),:), yval(idx(1:i)), theta, 0);
	error_train(i) = error_train(i) + etrain;
	error_val(i) = error_val(i) + eval;
    endfor
    error_train(i) = error_train(i) / nrepeat;
    error_val(i) = error_val(i) / nrepeat;
endfor

plot(2:m, error_train(2:m), 2:m, error_val(2:m));
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
axis([0 13 0 150])

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end

fprintf('Program paused. Press enter to continue.\n');
pause;

