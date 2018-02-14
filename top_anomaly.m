clc; clear all;

addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices
addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/csv

%filename = 'multi_user_paper_result.csv';
%filename = 'hp_paper_result.csv'
% filename = 'Result_comparison.xlsx'
% sheet = 2;
% xlRange = 'A2:R31';
% score = xlsread(filename,sheet,xlRange);

%data = load('seem_daytype.mat');
%load('seem_daytype.mat','seem_score','seem_result')
%load('hp_app_scores.mat','ac_scores','fridge_scores')
load('multi_user_app_scores.mat','ac_scores','fridge_scores')

X = ac_scores;
Y = fridge_scores;
%weekdays = rpca_score(1:22,:);
%weekends = rpca_score(23:end,:);
%month = rpca_score;
%vars = fieldnames(data);
% X = month;

row_size = size(X,1);
col_size = size(X,2);

for j = 1:col_size
    score_ac = X(:,j);
    [sortedValues,sortIndex] = sort(score_ac,'descend');
    score_final_ac{1,j} = sortedValues(sortedValues > 0.75);
    num = length(score_final_ac{1,j});
    result_final_ac{:,j} = sortIndex(1:num,1);
end

row_Y = size(Y,1);
col_Y = size(Y,2);

for k = 1:col_Y
    score_fridge = Y(:,k);
    [sortedValues1,sortIndex1] = sort(score_fridge,'descend');
    score_final_fridge{1,k} = sortedValues1(sortedValues1 > 0.75);
    num2 = length(score_final_fridge{1,k});
    result_final_fridge{:,k} = sortIndex1(1:num2,1);
end

%    % str = vars{1};
%    % specifier = sprintf('%s_result.mat',str);
save('multi_user_app_result.mat','result_final_ac','result_final_fridge','score_final_ac','score_final_fridge');
%  
%  %Call conversion function from weekday/end to monthly format
% [result1] = conv_day_mon(result) 
% result = result1;
% save('rpca_daytype_result.mat','result','score')


