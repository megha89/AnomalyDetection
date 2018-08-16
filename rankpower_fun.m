%%This file is Copyright (C) 2018 Megha Gaur.

function [avg_rank_power] = rankpower_fun(top_m,day_result_mat,gt_result_mat)

%UNTITLED3 Summary of this function goes here
% We have considered the case where m = 3 as seem can only work for
% anything less than 3.

col_size = size(day_result_mat,2);
row_size = size(day_result_mat,1);
top_m_known_gt = gt_result_mat(:,1:top_m);  %top m DAYS RETURNED FROM THE GT
top_m_anom_algo = day_result_mat(:,1:top_m); %top m DAYS returend from algo

for i = 1:row_size
        %[sorted_anom_score, sort_idx] = sort(gt_score_mat(i,:),'descend');
        %top_m_anom_idx = sort_idx(1:top_m)
        
        true_top_m_return = intersect(top_m_known_gt(i,:),top_m_anom_algo(i,:)); %known anomalies returned by algo
        num_true_out_ret = size(true_top_m_return,2); % #of known anomalies returned by algo 
        anom_present_algo(i,:) = intersect(top_m_known_gt(i,:),day_result_mat(i,:));
        num_anom_algo = numel(anom_present_algo(i,:));
        
        if num_anom_algo  < top_m
            num_anom_not_present = numel(setdiff(top_m_known_gt(i,:),anom_present_algo));
            
            if num_anom_not_present == top_m
                sum_rank_top_m = top_m*(col_size) + (1+2+3);
                rank_power(i) = (num_true_out_ret*(num_true_out_ret+1))/(2*sum_rank_top_m);
            else
            
                for j = 1:num_anom_algo
                    idx(j) = find(day_result_mat(i,:) == anom_present_algo(i,j));
                end
                sum_rank_top_m = sum(idx,2)+ (num_anom_not_present)*(col_size) + num_anom_not_present ;
                idx = [];
                rank_power(i) = (num_true_out_ret*(num_true_out_ret+1))/(2*sum_rank_top_m);
            end
               
        else
            if num_true_out_ret == top_m
                rank_power(i) = 1;
            else
                for j = 1:top_m
                   idx(j) = find(day_result_mat(i,:) == top_m_known_gt(i,j));
                end
                sum_rank_top_m = sum(idx,2);
                idx = [];
                rank_power(i) = (num_true_out_ret*(num_true_out_ret+1))/(2*sum_rank_top_m);
            end
            
        end
        
       anom_present_algo = [] ;
end
%end
avg_rank_power = mean(rank_power);
end

