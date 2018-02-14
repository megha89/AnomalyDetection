function [fscore,jaccard,tpr,tnr,fpr] = fscore_fun(day_result,day_score,gt_result,gt_score)
row_size = size(day_result,1);
%thres_size = numel(roc_thres);

for i = 1:row_size
    total_days = numel(gt_result(i,:));     
    gt_zero_score = find(gt_score(i,:)==0);      % Ground truth, days with zero anomaly score
    gt_pos_score = setdiff([1:total_days],gt_zero_score);   % Ground truth, days with non zero anomaly score
    
    zero_score_index = find(day_score(i,:)==0);            %Find index of days with zero score
    total_seem_days = day_result(i,:);                      % Total days considered as outliers using seem algo
    zero_score_day = total_seem_days(zero_score_index);          % From dataset, days with zero anomaly score assigned by seem algo
    day_pos_score = setdiff(total_seem_days,zero_score_day);     %From dataset, days with positive anomaly score
    day_zero_score = setdiff([1:total_days],day_pos_score);      %All the considered and non considered days with zero anomaly score
    
    tp = intersect(gt_pos_score,day_pos_score);
    tp_count = numel(tp);
    tn = intersect(gt_zero_score,day_zero_score);
    tn_count = numel(tn);
    fp = setdiff(day_pos_score,gt_pos_score);
    fp_count = numel(fp);
    fn = setdiff(day_zero_score,gt_zero_score);
    fn_count = numel(fn);
    prec = tp_count./(tp_count+fp_count);
    rec = tp_count./(tp_count+fn_count);
    if (prec == 0 & rec == 0)
        f_score{i} = 0;
    else
        f_score{i} = (2*prec*rec)./(prec+rec);
    end
    tpr{i} = (tp_count)./(tp_count+fn_count);
    tnr{i} = (tn_count)./(tn_count+fp_count);
    fpr{i} = 1-tnr{i};
    fnr{i} = 1-tpr{i};
    jaccard_idx(i,:) = (tp_count)./(tp_count+fp_count+fn_count);
    
end
tpr_mat = cell2mat(tpr(:));
tpr = nanmean(tpr_mat);
tnr_mat = cell2mat(tnr(:));
tnr = nanmean(tnr_mat);
fpr_mat = cell2mat(fpr(:));
fpr = nanmean(fpr_mat);

fscore_mat = cell2mat(f_score(:));
fscore = nanmean(fscore_mat);
jaccard = nanmean(jaccard_idx);

%save('tpr_fpr_weekday_11_multi.mat','tpr','fpr');
end
