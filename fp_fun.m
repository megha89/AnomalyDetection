function [avg_fp_100] = fp_fun(true_anom_thresh,day_result,gt_result,gt_score)
n = size(day_result,1);
for i = 1:n
%    norm_score = (gt_score(i,:)-min(gt_score(i,:)))./(max(gt_score(i,:))-min(gt_score(i,:))); %Normalise the score for each house
    [score_above_thres_gt,idx1] = find(gt_score(1,:) > true_anom_thresh);    %Find the anomalous scores that are above the threshold
    %true_anom_gt = gt_result(idx1);     %Using the indices of the scores, we can find the days that are highly anomalous
    num_outlier = numel(idx1);
    idx2 = ismember(day_result(i,:),idx1);  %Find the index of highly anom gt days in the result obtained from algo
    idx3 = find(idx2);
    if num_outlier == numel(idx3)
        max_idx_out_ret = max(idx3);
    else
        max_idx_out_ret = 11;   %As algo seem returns only 10 anomalous days (best case)
    end
    fp_100(i) = max_idx_out_ret - num_outlier;
    
end
avg_fp_100 = mean(fp_100);


end
