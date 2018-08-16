%%This file is Copyright (C) 2018 Megha Gaur.

function [label] = getScore(partition_data,pred_energy,user_thresh)

y_diff = (partition_data - pred_energy);
mean_y_diff = mean(y_diff);
sd_y_diff = std(y_diff);
z_score_y_part = abs((y_diff - mean_y_diff)./sd_y_diff);
label1 = z_score_y_part > user_thresh;
label2 = z_score_y_part < -user_thresh;

pos_anom_score = sum(label1,2);
neg_anom_score = sum(label2,2);
label = (pos_anom_score | neg_anom_score);


end
