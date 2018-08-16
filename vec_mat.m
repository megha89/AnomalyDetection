%%This file is Copyright (C) 2018 Megha Gaur.

clc; clear all;
% Change sheet, xlrange, reshape size and the mat filename.

addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices
addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/csv

filename = 'multi_user_appliance_result.csv';
sheet = 1;
%xlRange_april = 'P2:P193'

data = csvread(filename,1,0,[1,0,60,17]);
rows_data = size(data,1);
col_data = size(data,2);
m = rows_data/2; % New month starts
n = 10; % New appliance starts
 
ac_data = data(:,1:n);
fridge_data = data(:,n+1:end);
 
% % ac_april_data = ac_data(1:m,:);
% % ac_may_data = ac_data(m+1:end,:);
% % 
% % fridge_april_data = fridge_data(1:m,:);
% % fridge_may_data = fridge_data(m+1:end,:);
% 
ac_scores = reshape(ac_data,[30,20]);
fridge_scores = reshape(fridge_data,[30,16]);
save('multi_user_app_scores.mat','ac_scores','fridge_scores');


% load('weekend_ac_data.mat')
% 
% for i = 1:1
%     days_string = {'1','2','3','4','5','8','11','12','14','16'};
%     formatSpec1 = 'House%s_ac.mat';
%     X_mat_april = weekend_ac_april{i};
%     X_mat_may = weekend_ac_may{i};
%     %fridge_april_col = april_data(:,i);
%     %fridge_may_col = may_data(:,i);
%     %fridge_april_col = fridge_april_data(:,i);
%     %fridge_may_col = fridge_may_data(:,i);
%     
% %    weekday_ac_april = reshape(ac_april_col,[24,22]);
%  %   weekday_ac_may = reshape(ac_may_col,[24,22]);
%     %weekend_fridge_april{i} = reshape(fridge_april_col,[24,8]);
%     %weekend_fridge_may{i} = reshape(fridge_may_col,[24,8]);
%     A1 = days_string{i};
%     str = sprintf(formatSpec1,A1);
%     %save(str,'X_mat_april','X_mat_may')
% 
% end
% 
%save('rpca_daytype.mat','rpca_score')

% multi_april_weekend = csvread(filename,27,0,[27,0,34,8]);
% rows_data = size(multi_april_weekend,1)
% col_data = size(multi_april_weekend,2)
% 
% multi_may_weekday = csvread(filename,1,10,[1,10,22,18]);
% rows_data = size(multi_may_weekday,1)
% col_data = size(multi_may_weekday,2)
% 
% multi_may_weekend = csvread(filename,27,10,[27,10,34,18]);
% rows_data = size(multi_may_weekend,1)
% col_data = size(multi_may_weekend,2)

% X_mat_april = reshape(X_april,[24,8]);
% disp(size(X_mat_april))

%sheet = 2;
% xlRange_may = 'P2:P193'
% X_may = xlsread(filename,sheet,xlRange_may);
% rows_data = size(X_may,1)
% col_data = size(X_may,2)
% 
% X_mat_may = reshape(X_may,[24,8]);
% disp(size(X_mat_may))

