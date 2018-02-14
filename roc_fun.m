function [mean_auc, mean_pauc] = roc_fun(roc_thres,day_result,day_score,gt_result,gt_score)

row_size = size(day_result,1);
thres_size = numel(roc_thres);

for i = 1:row_size
    %for j = 1:thres_size

        [score_above_thres_gt,idx1] = find(gt_score(i,:) > roc_thres(1,j));    %Find the anomalous scores that are above the threshold
        num_outlier = numel(idx1);  %Returns the number of anomalous days for each house
        %idx2 = ismember(day_result(i,:),idx1)  %Find the index of highly anom gt days in the result obtained from algo
        %idx3 = find(idx2)
        %anom_algo = day_result(i,idx3)
        
        [score_above_thres_algo,idx2] = find(day_score(i,:) > roc_thres(1,j));
        anom_algo = day_result(i,idx2);
        non_anom_gt = setdiff(gt_result(i,:),idx1);
        non_anom_algo = setdiff(day_result(i,:),anom_algo);
        tp = intersect(idx1,anom_algo);
        tp_count = numel(tp);
        tn = intersect(non_anom_gt,non_anom_algo);
        tn_count = numel(tn);
        %fp = setdiff(anom_algo,idx1)
        fp = intersect(anom_algo,non_anom_gt);
        fp_count = numel(fp);
        fn = setdiff(non_anom_algo,non_anom_gt);
        fn_count = numel(fn);
        
        tpr(i,j) = (tp_count)./(tp_count+fn_count);
        tnr(i,j) = (tn_count)./(tn_count+fp_count);
%         if isnan(tnr(i,j))
%             tnr()
        fpr(i,j) = 1.-tnr(i,j);
    %end
end

for k = 1:row_size
    [sort_fpr(k,:),idx3] = sort(fpr(k,:));
    sort_tpr(k,:) = tpr(idx3);
    figure(1);
    hold on;
    set(gca, 'XLim', [0, get(gca, 'XLim') * [0; 1]]);
    set(gca, 'YLim', [0, get(gca, 'YLim') * [0; 1]]);
    plot(sort_fpr(k,:),sort_tpr(k,:));
    xlabel('False Positive Rate')
    ylabel('True Positive Rate')
    auc(k,:) = trapz(sort_fpr(k,:),sort_tpr(k,:));    
    [row_idx,col_idx,val] = find(sort_fpr(k,:) < 0.51);
    if isempty(row_idx)
        pauc{1,k} = nan;
    else
        fpr_pauc{1,k} = sort_fpr(k,col_idx(1,1):col_idx(1,end));
        tpr_pauc{1,k} = sort_tpr(k,col_idx(1,1):col_idx(1,end));
        pauc{1,k} = trapz(fpr_pauc{1,k},tpr_pauc{1,k});
    end
end

hold off;
mean_auc = nanmean(auc);
pauc_mat = cell2mat(pauc(:));
mean_pauc = nanmean(pauc_mat);


end
