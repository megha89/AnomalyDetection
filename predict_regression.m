function [pred_y] = predict_regression(data,coeff)
X = [ones(length(data(:,1)),1) data(:,1)];
pred_y = X * coeff;
end