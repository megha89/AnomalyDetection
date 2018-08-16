%%This file is Copyright (C) 2018 Megha Gaur.

%function [avg_fp_100] = fp_fun(true_anom_thresh,day_result,gt_result,gt_score)
function [avg_fp_100] = fp_fun(day_result,gt_result,gt_score)
n = size(gt_result,1);
m = size(gt_result,2);
r = size(day_result,2);
for i = 1:n
%    norm_score = (gt_score(i,:)-min(gt_score(i,:)))./(max(gt_score(i,:))-min(gt_score(i,:))); %Normalise the score for each house
    %[score_above_thres_gt,idx1] = find(gt_score(1,:) > true_anom_thresh);    %Find the anomalous scores that are above the threshold
    [~,idx_known_anom] = find(gt_score(i,:));
    ranked_true_anom = idx_known_anom;
    %[score_abv_thre,pos_days] = find(day_score(i,:) > 0);
    ranked_algo_anom = day_result(i,:);
    num_known_anom = numel(ranked_true_anom);
    num_algo_anom = numel(ranked_algo_anom);
    
    idx2 = ismember(ranked_algo_anom,ranked_true_anom);  %Find the index of highly anom gt days in the result obtained from algo
    num_anom_fp = find(idx2);
    if num_known_anom <= numel(num_anom_fp)
        tot_fp = max(num_anom_fp);
    else
        disp('false positive should be max')
        tot_fp = 0;    %As algo seem returns only 10 anomalous days (best case)
        num_known_anom = 0;
    end
    fp_100(i) = tot_fp - num_known_anom;
    
end
avg_fp_100 = mean(fp_100);


end
