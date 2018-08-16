%%This file is Copyright (C) 2018 Megha Gaur.

clc; clear all;

addpath /Users/mgaur/Documents/MATLAB/AnomalyDetection/Matrices


ground_truth = {[11;25],[6;26;30],[4;9;14;15;16],[30],[2;29],[5;7;8;9],[24;28],[5;27;29],[22],[27;30],[15;28],[30;12;23],[25;28;29],[7;21],[2;3;22],[12;23;29;30],[4;28],[9;26;30]}; %WEEKDAY
%ground_truth = {[12;13;17],[11;18;24],[5;19;20],[4;11],[12;27],[3;11;17],[27],[10;11],[5;6],[11;17;25],[13;19;27],[11;17],[19;27],[4;11],[12;13],[10;11;25],[27],[11]}; %WEEKEND
%ground_truth = {[27;12;13;11;25],[30;6;11;24;18;26],[14;4;15;9;16;5;19;20],[30;4;11],[27;12;2;29],[11;5;3;7;8;9;24],[27;24;28],[10;11;29;5;27],[5;16;22],[30;27;11;25;17],[13;15;19;27;28],[11;12;17;23;30],[19;25;27;28;29],[4;7;11;21],[2;3;12;13;22],[10;11;12;23;25;29;30],[28;27;4],[30;11;9;26]}; %METER COMBINED
%ground_truth = {[25;28],[7;26;28;30],[7;8;15;16],[30],[3;23;28;29],[5;30],[24;28],[5;29],[2;28],[29;30],[24;25;28;29],[12;30],[2;11;25;28],[21],[2;3;22],[12;29;30],[4;28],[26;30],[11;14],[30]};   % WEEKDAY AC
%ground_truth = {[27],[11],[19],[10;11],[12;27],[11;17],[27],[10;11],[12],[10;11],[26;27],[11],[27],[11;24],[27],[11;10],[27],[11],[27],[18]};   %WEEKEND AC
%ground_truth = {[25;27;28],[7;11;26;28;30],[7;8;15;16;19],[10;11;30],[3;12;23;27;28;29],[5;11;17;30],[24;27;28],[5;10;11;29],[2;12;28],[10;11;29;30],[24;25;26;27;28;29],[11;12;30],[2;11;25;27;28],[11;24;21],[2;3;22;27],[10;11;12;29;30],[4;27;28],[11;26;30],[11;14;27],[18;30]};    %APPLIANCE AC
%ground_truth = {[10],[2],[10],[15],[28],[14],[10],[30],[16],[27],[25;28],[12],[15],[30],[18],[14;30]};    %FRIDGE-WEEKDAY
%ground_truth = {[12;13;27],[17;18],[6;13;27],[11],[27],[11],[27],[25],[20],[24],[12;27],[17],[20],[11],[27],[10;17]};    %FRIDGE-WEEKEND
%ground_truth = {[10;12;13;27],[2;17;18],[6;10;13;27],[11;15],[27;28],[11;14],[10;27],[25;30],[16;20],[24;27],[12;25;27;28],[12;17],[15;20],[11;30],[18;27],[10;14;17;30]};    %FRIDGE-MERGED


row_size = size(ground_truth,1);
col_size = size(ground_truth,2);

%load('hp_data_result.mat','result','score') %HP daytype meter-level results
%load('seem_data_result.mat','result','score')  %Seem daytype meter-level results
%load('multiuser_data_result.mat','result','score') % multiuser daytype meter-level results
load('rpca_daytype_result.mat','result','score') %RPCA daytype meter level results

%load('hp_app_result.mat','result_final_ac','score_final_ac','result_final_fridge','score_final_fridge') %HP daytype results for AC and fridge appliance 
%load('multi_user_app_result.mat','result_final_ac','score_final_ac','result_final_fridge','score_final_fridge') % multiuser daytype results for AC and fridge appliance
%load('RPCA_fridge_daytype.mat','result');   %RPCA daytype results for fridge 
%load('seem_fridge_daytype_result.mat','result'); % Seem daytype results for fridge
%load('seem_ac_daytype_result.mat','result'); % Seem daytype results for AC

%result =result_ac;

%filename = 'hp_paper_result.csv';
% filename = 'multi_user_paper_result.csv';
% %X = csvread(filename,25,1);    %hp_paper
% X = csvread(filename,12,1);     %multiuser
% rows_data = size(X,1)
% col_data = size(X,2)
% for i = 1:col_data
%     result{i} = X((X(:,i)~=0),i);
% end
%disp(size(result))

%result = result_final_ac;
%score = score_final_ac;

col_size = size(result,2);
for i = 1:col_size
    
    false_neg = setdiff(ground_truth{i},result{i});
    fn_count = numel(false_neg);
    false_pos = setdiff(result{i},ground_truth{i});
    fp_count = numel(false_pos);
    true_pos = intersect(ground_truth{i},result{i});
    tp_count = numel(true_pos)
    prec = tp_count./(tp_count+fp_count);
    rec = tp_count./(tp_count+fn_count);
    f_score{i} = (2*prec*rec)/(prec+rec)
end

disp(f_score);
f_score(cellfun(@isnan,f_score))={0}
mean_a = mean(cellfun(@(x) mean(x(:)), f_score))


%%APPLIANCE LEVEL (AC context daytype
% figure(1)
% t = {'hpPaper','seem_paper','multiuser','RPCA'};
% tech = [1,2,3,4];
% fscore = [0.3143,0.5663,0.6035,0.5575];
% bar(tech,fscore)
% xlabel('TECHNIQUES');
% ylabel('AVERAGE FSCORE (ALL HOUSES)');
% title('COMPARISON OF TECHNIQUES')


% %% METER LEVEL CONTEXT DAYTYPE 
% figure(1)
% t = {'hpPaper','seem_paper','multiuser','RPCA'};
% tech = [1,2,3,4];
% fscore = [0.3013,0.5304,0.4812,0.6124];
% bar(tech,fscore)
% xlabel('TECHNIQUES');
% ylabel('AVERAGE FSCORE (ALL HOUSES)');
% title('COMPARISON OF TECHNIQUES')
% legend('1','2','3','4','DisplayName','hpPaper','seem_paper','multiuser','RPCA');


%APPLIANCE-FRIDGE
% figure(1)
% t = {'hpPaper','seem_paper','multiuser','RPCA'};
% tech = [1,2,3,4];
% fscore = [0.1799,0.6582,0.1047,0.2449];
% bar(tech,fscore)
% xlabel('TECHNIQUES');
% ylabel('AVERAGE FSCORE (ALL HOUSES)');
