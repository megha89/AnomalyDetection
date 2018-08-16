%%This file is Copyright (C) 2018 Megha Gaur.

function [anom_data] = compute_zscore(y_pred,anom_mat,user_thresh)

mean_values = mean(y_pred(:,end));
std_values = std(y_pred(:,end));

 for i = 1: size(anom_mat,1)
    zscore(i) = (anom_mat(i,3) - mean_values)./std_values; %Subtracting the mean of predicted energy from the anom energy.
 end
anom_data = anom_mat((zscore > user_thresh),1);
end