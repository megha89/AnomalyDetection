%%This file is Copyright (C) 2018 Megha Gaur.

clc; clear all;

%load('RPCA_weekend_app_lamda980.mat','result','score')
load('seem_weekday_ac_result.mat','result','score')
[result1] = conv_day_mon(result);
res1 = result1;
sco1 = score;

%load('RPCA_weekday_app_lamda531.mat','result','score')
load('seem_weekend_ac_result.mat','result','score')
[result2] = conv_end_mon(result);
res2 = result2;
sco2 = score;

len = length(res2);
disp(res1)
disp(res2)

for i = 1:len
    num1 = numel(res1{1,i})
    if num1 == 0
        num2 = numel(res2{1,i})
        if num2 == 0
            continue;
        else
        num3 = num1+num2
        temp{1,i}(1,num1+1:num3) = res2{1,i}
        continue;
        end
    else
        temp{1,i}(1,1:num1) = res1{1,i}
    end
    %temp{1,i}(1,1:num1) = res1{1,i}
    num2 = numel(res2{1,i})
    num3 = num1+num2
    
    if num2 == 0
        continue;
    else
        temp{1,i}(1,num1+1:num3) = res2{1,i}
    end
end
result = temp;


save('seem_ac_daytype_result.mat','result');
%res_mat = cell2mat(cat(1,res1,res2))
% result = reshape(cell2mat(anom_days),[10,18])
% score = reshape(cell2mat(z_score_norm),[10,18])