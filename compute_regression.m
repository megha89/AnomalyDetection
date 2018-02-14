function [B] = compute_regression(data)

X = [ones(size(data,1),1) data(:,1)];
Y = data(:,2);
B = mldivide(X,Y);     % mldivide(X1,Y1) to compute the regression coefficients

end

