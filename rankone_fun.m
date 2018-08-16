%%This file is Copyright (C) 2018 Megha Gaur.

function [mean_rankone, sd_rankone] = rankone_fun(result,score,gt_result,gt_score)
%row_size = size(gt_result,1);
%col_size = size(gt_result,2);
top_anom_day = [];
col_size = size(result,2);
%disp(result)

for iter = 1:100
    for i = 1:col_size
        
        [top_value,top_value_pos] = max(score{1,i});
        %disp(score{1,i})
        %disp(size(score{1,i}))
        
        if top_value ~= 1
            anom_day = result{1,i}(top_value_pos,1);
        elseif isempty(top_value)
            anom_day = 0;
        else
            [sorted_value,sorted_index] = sort(score{1,i},1,'descend');
            count_anom_days = numel(sorted_value(sorted_value==1));
            random_anom_index = randi(count_anom_days);
            anom_day = result{1,i}(random_anom_index,1);
        end
        top_anom_day(i) = anom_day;
        
    end

    acc = 0;
    for i = 1:col_size
        cell_res = gt_result{1,i}(1,1);
        vec_res = top_anom_day(1,i);
        if cell_res == vec_res
            acc = acc+1;
        end
    end
    rank_one_acc(iter) = (acc/col_size)*100;
end
mean_rankone = mean(rank_one_acc)
sd_rankone = std(rank_one_acc)
end

