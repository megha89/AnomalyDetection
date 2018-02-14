% Calculating fscore using the saved result matrices of the  
clc; clear all;

%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/RPCA_weekday_ac_lamda_mat
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/RPCA_weekend_ac_lamda_mat/
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/RPCA_weekday_lamda_mat/
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/RPCA_weekend_lamda_mat/

%ground_truth = {[27;12;13;11;25],[30;6;11;24;18;26],[14;4;15;9;16;5;19;20],[30;4;11],[27;12;2;29],[11;5;3;7;8;9;24],[27;24;28],[10;11;29;5;27],[5;16;22],[30;27;11;25;17],[13;15;19;27;28],[11;12;17;23;30],[19;25;27;28;29],[4;7;11;21],[2;3;12;13;22],[10;11;12;23;25;29;30],[28;27;4],[30;11;9;26]};    % MONTHLY
%ground_truth = {[11;25],[6;26;30],[4;9;14;15;16],[30],[2;29],[5;7;8;9],[24;28],[5;27;29],[22],[27;30],[15;28],[30;12;23],[25;28;29],[7;21],[2;3;22],[12;23;29;30],[4;28],[9;26;30]}; %WEEKDAY
%ground_truth = {[12;13;17],[11;18;24],[5;19;20],[4;11],[12;27],[3;11;17],[27],[10;11],[5;6],[11;17;25],[13;19;27],[11;17],[19;27],[4;11],[12;13],[10;11;25],[27],[11]}; %WEEKEND
%ground_truth = {[25;28],[7;26;28;30],[7;8;15;16],[30],[3;23;28;29],[5;30],[24;28],[5;29],[2;28],[29;30],[24;25;28;29],[12;30],[2;11;25;28],[21],[2;3;22],[12;29;30],[4;28],[26;30],[11;14],[30]};   % WEEKDAY AC
ground_truth = {[27],[11],[19],[10;11],[12;27],[11;17],[27],[10;11],[12],[10;11],[26;27],[11],[27],[11;24],[27],[11;10],[27],[11],[27],[18]};   %WEEKEND AC

row_size = size(ground_truth,1);
col_size = size(ground_truth,2);
k=0;

%for n = 275:1:285
for n = 1:2:999
    k = k+1;
    formatSpec1 = 'RPCA_weekend_app_lamda%d.mat';
    A1 = n;
    %A1 = 2^n;
    result_mat = sprintf(formatSpec1,A1);
    mat = load(result_mat);
    f = fieldnames(mat);
    result = getfield(mat,f{1});
    
    %[result1] = conv_day_mon(result);   %WEEKDAYS TO MONTHLY FORMAT
    [result1] = conv_end_mon(result);    %WEEKENDS TO MONTHLY FORMAT
    
    for i = 1:col_size
        disp(ground_truth{i})
        disp(result{i}) 
        false_neg = setdiff(ground_truth{i},result1{i});
        fn_count = numel(false_neg);
        false_pos = setdiff(result1{i},ground_truth{i});
        fp_count = numel(false_pos);
        true_pos = intersect(ground_truth{i},result1{i});
        tp_count = numel(true_pos);
        prec = tp_count./(tp_count+fp_count);
        rec = tp_count./(tp_count+fn_count);
        f_score{i} = (2*prec*rec)/(prec+rec);
    end

    disp(f_score);
    f_score(cellfun(@isnan,f_score))={0};
    mean_a{k} = mean(cellfun(@(x) mean(x(:)), f_score));
end

disp(mean_a)
figure;
%lambda = [2,4,8,16,32,64,128,256,512,1024];
lambda = 1:2:999;
plot(lambda,[mean_a{:}])
xlabel('Lambda');
ylabel('Average fscore');
title('Lambda vs Average fscore')

