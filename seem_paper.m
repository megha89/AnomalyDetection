%Implementing seem paper on anomaly detection
clc; clear all;


%Do grouping based on day type, weekends & weekdays. THINGS TO CHANGE,
%1. dataset based on the day type and 2. variable 'total_days' which is 22 for
%weekdays and 8 for weekends and 3. the variable name that is to be saved.

%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_weekday_house_mat/
addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_weekend_house_mat/
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_weekday_app_mat/
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_weekend_app_mat/
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_house_app_mat/
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_house_matrix/

k = 1;
for i = 1:9
        days_string = {'1','2','3','4','5','8','11','12','14','16'};
        %days_string = {'8'};
        %days_string = {'11'};
        formatSpec1 = 'House%s.mat';
        A1 = days_string{i};
        str = sprintf(formatSpec1,A1);
        house_data = load(str);
        house_fields = fieldnames(house_data);
        
        for j = 1:numel(house_fields)
        %for j = 2
            X = house_data.(house_fields{j});
            disp(house_fields{j})
            rows_data = size(X,1);
            col_data = size(X,2);
            X_avg_day = mean(X,1);
            n_u = floor(0.5*(col_data-1));      %Max no of anomalous days
            alpha = 0.01;
            X_list = X_avg_day;
            num_list = size(X_list,2);
            outlier_day  = [];
            outlier_value = [];
            
            
            %Step 1
            n_out = 0;
            
            for i = 1:n_u
                %for i = 1:10
    
                %Step 2
                X_avg_month = mean(X_list);
                
                %Step 3
                X_std_month = std(X_list);
                
                %Step 4
                if X_std_month == 0
                    disp('Standard Deviation is ZERO, NO More Anomaly');
                    break;
                    
                else
        
                    %Step 5
                    X_ext = abs(X_list - X_avg_month);
                    max_X_ext = max(X_ext);
                    [max_X_list,pos_x_list] = max(X_list);
                    %  max_value_X_list = X_list(pos_x_ext)
                    top_ith_day = find((X_avg_day == max_X_list),1);
                    
                    %  [sortedValues,sortIndex] = sort(X_list(:),'descend');
                    % top_ith_value = sortedValues(1);
                    %         top_ith_day = find((X_avg_day == top_ith_value),1)
                    %         %top_ith_day = sortIndex(1)
                end
                
                %Step 6
                R = abs(max_X_ext - X_avg_month)/X_std_month;
                
                %Step 7
                dof = num_list-i-1;
                p = alpha/2*(num_list-i+1);
                t = tpdf(dof,p);
                lambda = (num_list-i)*t/sqrt((num_list-i+1)*(num_list-i-1+power(t,2)));
    
                %Step 8
                if R> lambda;
                    n_out = i;
                    X_list(pos_x_list) = [];
                    num_list = size(X_list,2);
                    outlier_day(i)= top_ith_day;
                   % outlier_value(i) = top_ith_value;
                else
                    
                    disp('R is less than lambda');
                    X_list(pos_x_list) = [];
                    num_list = size(X_list,2);
                    
                end
    
            end
            
            anom_days{k} = outlier_day;
%             anom_mat = cell2mat(anom_days);
%             anom_mat = anom_mat(anom_mat~=0);
%             disp(outlier_day)
%             if all(outlier_day) == 0
%                 disp('Zero element present');
%                 outlier_value = X_avg_day(anom_mat);
%             else
%                 disp('Zero element absent');
%                 outlier_value = X_avg_day(outlier_day);
%             end
            %REMOVE ALL EMPTY CELLS
            
            outlier_day = outlier_day(outlier_day~=0);
            outlier_value = X_avg_day(outlier_day);
            
%%             
% FINDING Z SCORE
            total_days = [1:1:col_data];                       
            non_out_day = setdiff(total_days,outlier_day);
            non_out_values = X_avg_day(non_out_day);
            mean_non_out = mean(non_out_values);
            sd_non_out = std(non_out_values);
            if sd_non_out == 0
                z_score = outlier_value;
            else
                z_score = (outlier_value - mean_non_out)./sd_non_out;
            end
            
            min_val = min(z_score(:));
            max_val = max(z_score(:));
            %z_score_norm{k} = (z_score - min_val)/(max_val - min_val);
            if isempty(z_score)
                z_score_norm = 0;
            else
                z_score_norm = (z_score - min_val)/(max_val - min_val);
                %top_values = z_score_norm(z_score_norm> 0.75);
                %top_days = outlier_day(1:size(top_values,2));
            end
            
            %top_values = z_score_norm(z_score_norm> 0.75);
            %top_days = outlier_day(1:size(top_values,2));
            %result{k} = top_days;
            %score{k} = top_values;
            result{k} = outlier_day;
            score{k} = z_score_norm;
            k=k+1;
        end        
        
end
   

  save('seem_weekend_meter.mat','result','score')
  %top_values = z_score_norm(z_score_norm> 0.75);
  %top_days = outlier_day(1:size(top_values,2));
  %result1{k} = top_days;
  %score1{k} = top_values;
  %k=k+1;

% result = reshape(cell2mat(anom_days),[10,18])
% score = reshape(cell2mat(z_score_norm),[10,18])
%disp(result1)
%save('seem_weekday_app_result.mat','result1','score1')
%save('seem_weekend_app_result.mat','result1','score1')
% result = result1;
% score = score1;
% save('seem_wo_context_result.mat','result','score')

