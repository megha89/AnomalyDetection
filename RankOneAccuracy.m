clc; clear all;

addpath /Users/mgaur/Documents/MATLAB/AnomalyDetection/Matrices

ground_truth = [27,11,15,30,27,11,27,11,5,30,15,30,27,4,12,11,27,30]; %METER COMBINED
%ground_truth = [27,11,16,30,27,30,27,11,12,29,28,30,27,21,12,12,27,30,27,5];   %AC
%ground_truth  = [13,17,10,11,28,11,10,30,20,24,12,12,15,30,27,14]; %FRIDGE

row_size = size(ground_truth,1);
col_size = size(ground_truth,2);

top_anom_day = [];

%load('hp_data_result.mat','result','score')
%load('seem_data_result.mat','result','score')
%load('multiuser_data_result.mat','result','score')
%load('rpca_daytype_result.mat','result','score')
%load('hp_app_result.mat','result_final_ac','result_final_fridge','score_final_ac','score_final_fridge');
%load('multi_user_app_result.mat','result_final_ac','result_final_fridge','score_final_ac','score_final_fridge');
%load('seem_app_fridge_result.mat','result','score');
%load('seem_meter_wo_result.mat','result','score');
%load('seem_app_ac_result.mat','result','score');

%filename = 'hp_paper_result.csv';
%filename = 'multi_user_paper_result.csv';
%X = csvread(filename,25,1,[25,1,46,18]);    %hp_paper
%Y = csvread(filename,1,1,[1,1,22,18]);    %hp_paper
%X = csvread(filename,12,1,[12,1,18,18]);    %multiuser
%Y = csvread(filename,1,1,[1,1,7,18]);       %multiuser

% col_X = size(X,2)
% 
% for i = 1:col_X
%     result{i} = X((X(:,i)~=0),i)
%     score{i} = Y((Y(:,i)~=0),i);
% end

% result = result_final_ac;
% score = score_final_ac;

col_size = size(result,2);
disp(result)

for iter = 1:100
    for i = 1:col_size
        
        [top_value,top_value_pos] = max(score{1,i});
        disp(score{1,i})
        disp(size(score{1,i}))
        
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
        if ground_truth(1,i) == top_anom_day(1,i)
            acc = acc+1;
        end
    end
    rank_one_acc(iter) = (acc/col_size)*100;
end
mean_acc = mean(rank_one_acc)
std_rank_one = std(rank_one_acc)


%%APPLIANCE LEVEL-FRIDGE
% t = {'hpPaper','seem_paper','multiuser','RPCA'};
% tech = [1,2,3,4];
% rank_one = [18.5625,68.75,4.125,31.25 ];
% std = [4.4819,0,3.9946,0]
% bar(tech,rank_one)
% xlabel('TECHNIQUES');
% ylabel('Rank-One Accuracy');

%APPLIANCE LEVEL-AC
% t = {'hpPaper','seem_paper','multiuser','RPCA'};
% tech = [1,2,3,4];
% rank_one = [12.55,60,27.65,50];
% std = [4.99,0,8.6,0]
% bar(tech,rank_one)
% xlabel('TECHNIQUES');
% ylabel('Rank-One Accuracy');


%%  METER LEVEL
% t = {'hpPaper','seem_paper','multiuser','RPCA'};
% tech = [1,2,3,4];
% rank_one = [24.27,61.11,22.05,77.78];
% std = [2.69,0,8.41,0]
% bar(tech,rank_one)
% xlabel('TECHNIQUES');
% ylabel('Rank-One Accuracy');


