%%This file is Copyright (C) 2018 Megha Gaur.

function [params0,params1,params2] = gridsearch_params(sort_data)
%Check for the number of pieces in piecewise linear regression required for best fit

%For 0 breakpoint or 1 piece linear regression
[b0] = compute_regression(sort_data);
params0 = b0;


%For 1 breakpoint or 2 piece linear regression
min_temp = min(sort_data(:,1));
max_temp = max(sort_data(:,1));
count = 1;
bp1 = min_temp:0.1: max_temp;
for i = min_temp:0.1: max_temp
    rows_part1 = sort_data(:,1) <=i;
    rows_part2 = sort_data(:,1) > i;
    data_part1 = sort_data(rows_part1,:);
    data_part2 = sort_data(rows_part2,:);
    b1 = compute_regression(data_part1);
    b2 = compute_regression(data_part2);
    coef_part1(count,:) = b1';
    coef_part2(count,:) = b2';
    count = count + 1;

end
params1 = [bp1' coef_part1 coef_part2];


%For 2 breakpoint or 3 piece linear regression
count = 1;

for j = min_temp:0.1:(max_temp-0.1)
    for k = (j+0.05):0.1:max_temp
         rows_part1 = sort_data(:,1) <=j;
         rows_part2 = sort_data(:,1) > j & sort_data(:,1) <= k;         
         rows_part3 = sort_data(:,1) > k;
         data_part1 = sort_data(rows_part1,:);
         data_part2 = sort_data(rows_part2,:);
         data_part3 = sort_data(rows_part3,:);
         b1 = compute_regression(data_part1);
         b2 = compute_regression(data_part2);
         b3 = compute_regression(data_part3);
         coef_part1(count,:) = b1';
         coef_part2(count,:) = b2';
         coef_part3(count,:) = b3';
         bp(count,:) = [j k];
         count = count + 1;
    
    end
end
params2 = [bp coef_part1 coef_part2 coef_part3];

%save('red_train1_coeff_0_1.mat','params0','params1','params2','sort_data');
end


