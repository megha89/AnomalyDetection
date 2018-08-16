%%This file is Copyright (C) 2018 Megha Gaur.

clc; clear;
%addpath C:\Users\mgaur\Documents\MATLAB\AnomalyDetection\Matrices\Pecan_weekday_house_mat
%addpath C:\Users\mgaur\Documents\MATLAB\AnomalyDetection\Matrices\Pecan_weekend_house_mat\
%addpath /Users/meghagupta/sfuvault/Documents/MATLAB/MetricEvaluation/Matrices/Pecan_weekday_house_mat/
addpath /Users/meghagupta/sfuvault/Documents/MATLAB/MetricEvaluation/Matrices/Pecan_weekend_house_mat/


%Vary 'user_threshold' to generate ground truth at different standard
%deviations.

total = 0;
for i = 1:9
    days_string = {'1','2','3','4','5','8','11','12','14','16'};
    %days_string = {'4'};
    formatSpec1 = 'House%s.mat';
    A1 = days_string{i};
    str = sprintf(formatSpec1,A1);
    house_data = load(str);
    house_fields = fieldnames(house_data);
    
     for j = 1:numel(house_fields)
        disp(house_fields{j});
        X = house_data.(house_fields{j});
        rows_data = size(X,1);
        col_data = size(X,2);
        mean_monthly = mean(X,2);           %Compute the mean per hour for all days of a house
        sd_monthly = std(X,0,2);               %Compute per hour for all days of a house
        mean_monthly = repmat(mean_monthly,1,col_data);     %repeated column vector 
        sd_monthly = repmat(sd_monthly,1,col_data);     % repeated column vector
        z_score = (X-mean_monthly)./sd_monthly;  % z-score is calculated for each element in a matrix 
        %abs_zscore_day = sum(abs(z_score),1); %Sum of absolute values of zscore
        %abs_zscore_day = sum(z_score,1);  %Total SD on both sides
        user_threshold = 2;
        positive_zscore_day = sum(z_score.*(z_score>0),1);       %Computes the sum of the per day positive z-scores
        [sort_pos_zscore, rank_pos_zscore] = sort(positive_zscore_day,'descend');    % Sorts the positive z-scores at day-level and rank them.
        %prompt = 'Please enter the threshold standard deviation';
        %user_threshold = input(prompt);        
        
        label1 = z_score > user_threshold ;
        label2 = z_score < -user_threshold;
        
        score_day1 = sum(label1,1);
        score_day2 = sum(label2,1);
        net_score = score_day1 - score_day2;    %Find the net score 
        
        
        [sorted_label,pos]= sort(net_score,2,'descend');
%         if j==1
%             [weekday_rank_april] = conv_day_mon_april(num2cell(pos));
%         else
%             [weekday_rank_may] = conv_day_mon_may(num2cell(pos));
%         end

        [label_group,idx_st] = unique(sorted_label);    %FInd the starting index of days with unique scores
        [occurence,label_groups]=hist(sorted_label,label_group);   %Finds the number of elements in each group (days with same score)
        zscore_aboveThresh_day = sum(z_score.*(z_score>user_threshold),1);   % Sum of day-level positive zscores that are greater than the user defined threshold.
        
        for k = 1:numel(label_groups)
            if occurence(1,k) == 1
                idx_end(k,1) = occurence(1,k)+idx_st(k,1)-1;
                continue;
            else
                idx_end(k,1) = occurence(1,k)+idx_st(k,1)-1;    %Find the last index of the day with same score in sorted list
                days_group = pos(idx_st(k,1):idx_end(k,1));     % FInd all the days in the same group
                [sort_group,idx_sort_group] = sort(zscore_aboveThresh_day(days_group),'descend'); %Sort days in the group on the basis of sum of zscore > threshold
                sort_days_group = days_group(idx_sort_group);
                pos(idx_st(k,1):idx_end(k,1)) = sort_days_group;
                
            end 
        end
        
     total=total+1;
    
     ground_truth_weekend{total} = pos;
     %gt_result{total} = pos;
     ground_truth_score{total} = net_score;
     max_score_month{total} = max(ground_truth_score{total});
     min_score_month{total} = min(ground_truth_score{total});
     score_weekend{total} = (ground_truth_score{1,total}-min_score_month{total})./(max_score_month{total}-min_score_month{total});
     %gt_score{total} = (ground_truth_score{1,total}-min_score_month{total})./(max_score_month{total}-min_score_month{total});
     
     %plot(X,'-ok')
     %title('Energy data marked with anomalies');
     figure(j);
     clf;
     max_y = max(X(:));     %Set y-axis limit to max of energy consumed in the month
     
     for k = 1:col_data
         subplot(5,4,k);    
         ylim([0 max_y]);   %y-axis limit set from 0 to max_y
         xlim([1 24]);      %x-axis limit set to hours of the day
         data_day = X(:,k); 
         hold on;
         %disp(label(:,k));
         ind1 = find(label1(:,k));    %Finds the index of non-zero elements (position of anomalies) from the label matix
         ind2 = find(label2(:,k));
         if isempty(ind1)    % condition to check if any anomaly exists or not
         else
             plot(ind1,data_day(ind1),'or');    %if anomaly exists, plot the energy data with respective anomalies. 
         end
         if isempty(ind2)    % condition to check if any anomaly exists or not
         else
             plot(ind2,data_day(ind2),'*k');    %if anomaly exists, plot the energy data with respective anomalies. 
         end
         plot(data_day);
         hold off;
     end 
     
     end 
        
end

%save('gt_weekend_meter_dataset_2.mat','ground_truth_weekend','score_weekend');  %
%save('gt_weekend_meter_dataset.mat','ground_truth_weekend','score_weekend')
%save('gt_weekend_meter_9.mat','gt_result','gt_score'); %threshold is 20% or 0.26 sd
%save('gt_weekend_meter_dataset_4.mat','ground_truth_weekend','score_weekend'); %thresh 70% or 1.05
