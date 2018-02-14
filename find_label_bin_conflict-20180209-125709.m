function [anom_data] = find_label_bin(label_anom,tmp_idx,user_thresh,Y_pred_part)

idx_anom = find(tmp_idx(:,2) == label_anom);
anom_mat = tmp_idx(idx_anom,:);
[anom_data] = compute_zscore(Y_pred_part,anom_mat,user_thresh);

end
