function [best_params] = test_validation(params0,params1,params2,sort_valid1)
X = [ones(length(sort_valid1(:,1)),1) sort_valid1(:,1)];

%One piece Regression, that is 0 breakpoint
y_pred = X*params0;
rsq0 = 1-(sum((sort_valid1(:,2)-y_pred).^2)/sum((sort_valid1(:,2) - mean(sort_valid1(:,2))).^2));
partition_data1 = [sort_valid1(:,1) sort_valid1(:,2) y_pred];
%plot_data(partition_data1,[0 0 0],[0 0 0])
close(gcf);
clearvars partition_data1 y_pred

%2-pc regression, 1 breakpoint
for i = 1:1:size(params1,1)
    rows_part1 = sort_valid1(:,1) <=params1(i,1);
    rows_part2 = sort_valid1(:,1) > params1(i,1);
    data_part1 = sort_valid1(rows_part1,:);
    data_part2 = sort_valid1(rows_part2,:);
    y_actual = [data_part1(:,2) ; data_part2(:,2)];
    x_part1 = [ones(length(data_part1(:,1)),1) data_part1(:,1)];
    x_part2 = [ones(length(data_part2(:,1)),1) data_part2(:,1)];
    if isempty(data_part1) && isempty(data_part2)
       y_pred_part1 = 0;
       y_pred_part2 = 0;
       y_pred = 0;
       y_denom = 0;
    elseif isempty(data_part1)
        y_pred_part1 = 0;
        y_pred_part2 = x_part2 * params1(i,4:5)';
        y_pred = y_pred_part2;
        y_denom = data_part2(:,2)-mean(data_part2(:,2));
    elseif isempty(data_part2)
        y_pred_part1 = x_part1 * params1(i,2:3)';
        y_pred_part2 = 0;
        y_pred = y_pred_part1;
        y_denom = data_part1(:,2)-mean(data_part1(:,2));
    else
        y_pred_part1 = x_part1 * params1(i,2:3)';
        y_denom_part1 = data_part1(:,2)-mean(data_part1(:,2));
        y_pred_part2 = x_part2 * params1(i,4:5)';
        y_denom_part2 = data_part2(:,2)-mean(data_part2(:,2));
        y_pred= [y_pred_part1 ; y_pred_part2];
        y_denom = [y_denom_part1 ; y_denom_part2];
%         partition_data1 = [data_part1(:,1) data_part1(:,2) y_pred_part1];
%         partition_data2 = [data_part2(:,1) data_part2(:,2) y_pred_part2];
        %plot_data(partition_data1,partition_data2,[0 0 0])
        %close(gcf);
    end

    Rsq1_part1(i) = 1-(sum((data_part1(:,2)-y_pred_part1).^2)/sum((data_part1(:,2)-mean(y_pred_part1)).^2));
    Rsq1_part2(i) = 1-(sum((data_part2(:,2)-y_pred_part2).^2)/sum((data_part2(:,2)-mean(y_pred_part2)).^2));
    cd1(i) =  1-(sum((y_actual-y_pred).^2)./(sum(y_denom.^2)));

end
[rsq1_p1,idx_rsq1_p1] = max(Rsq1_part1);
[rsq1_p2,idx_rsq1_p2] = max(Rsq1_part2);
[maxcd1,idx_cd1] = max(cd1);
%plot_data(partition_data1,partition_data2,[0 0 0])

clearvars partition_data1 partition_data2 y_pred
%%3-pc regression, 2 breakpoints

for i = 1:1:size(params2,1)
    rows_part1 = sort_valid1(:,1) <=params2(i,1);
    rows_part2 = sort_valid1(:,1) > params2(i,1) & sort_valid1(:,1) <= params2(i,2);
    rows_part3 = sort_valid1(:,1) > params2(i,2);
    data_part1 = sort_valid1(rows_part1,:);
    data_part2 = sort_valid1(rows_part2,:);
    data_part3 = sort_valid1(rows_part3,:);
    y_actual = [data_part1(:,2) ; data_part2(:,2); data_part3(:,2)];
    x_part1 = [ones(length(data_part1(:,1)),1) data_part1(:,1)];
    x_part2 = [ones(length(data_part2(:,1)),1) data_part2(:,1)];
    x_part3 = [ones(length(data_part3(:,1)),1) data_part3(:,1)];
    if isempty(data_part1) && isempty(data_part2) && isempty(data_part3)
       y_pred_part1 = 0;
       y_pred_part2 = 0;
       y_pred_part3 = 0;
       y_pred = 0;
       y_denom = 0;
    elseif isempty(data_part1) && isempty(data_part2)
       y_pred_part1 = 0;
       y_pred_part2 = 0;
       y_pred_part3 = x_part3 * params2(i,7:8)';
       y_denom = data_part3(:,2) - mean(data_part3(:,2));
       y_pred = y_pred_part3;
       
    elseif isempty(data_part1) && isempty(data_part3)
        y_pred_part1 = 0;
        y_pred_part2 = x_part2 * params2(i,5:6)';
        y_pred_part3 = 0;
        y_pred = y_pred_part2;
        y_denom = data_part2(:,2) - mean(data_part2(:,2));
        
    elseif isempty(data_part2) && isempty(data_part3)
        y_pred_part1 = x_part1 * params2(i,3:4)';
        y_pred_part2 = 0;
        y_pred_part3 = 0;
        y_pred = y_pred_part1;
        y_denom = data_part1(:,2) - mean(data_part1(:,2)); 
        
    elseif isempty(data_part1)
        y_pred_part1 = 0;
        y_pred_part2 = x_part2 * params2(i,5:6)';
        y_pred_part3 = x_part3 * params2(i,7:8)';
        y_pred = [y_pred_part2;y_pred_part3];
        y_denom_part2 = data_part2(:,2) - mean(data_part2(:,2));
        y_denom_part3 = data_part3(:,2) - mean(data_part3(:,2));
        y_denom = [y_denom_part2 ; y_denom_part3];
        
    elseif isempty(data_part2)
        y_pred_part1 = x_part1 * params2(i,3:4)';
        y_pred_part2 = 0;
        y_pred_part3 = x_part3 * params2(i,7:8)';
        y_pred = [y_pred_part1;y_pred_part3];
        y_denom_part1 = data_part1(:,2) - mean(data_part1(:,2));
        y_denom_part3 = data_part3(:,2) - mean(data_part3(:,2));
        y_denom = [y_denom_part1 ; y_denom_part3];
        
    elseif isempty(data_part1)
        y_pred_part1 = 0;
        y_pred_part2 = x_part2 * params2(i,5:6)';
        y_pred_part3 = x_part3 * params2(i,7:8)';
        y_pred = [y_pred_part2 ; y_pred_part3];
        y_denom_part2 = data_part2(:,2) - mean(data_part2(:,2));
        y_denom_part3 = data_part3(:,2) - mean(data_part3(:,2));
        y_denom = [y_denom_part2 ; y_denom_part3];
        
    else
        y_pred_part1 = x_part1 * params2(i,3:4)';
        y_denom_part1 = data_part1(:,2) - mean(data_part1(:,2));
        y_pred_part2 = x_part2 * params2(i,5:6)';
        y_denom_part2 = data_part2(:,2) - mean(data_part2(:,2));
        y_pred_part3 = x_part3 * params2(i,7:8)';
        y_denom_part3 = data_part3(:,2) - mean(data_part3(:,2));
        y_pred = [y_pred_part1 ; y_pred_part2 ; y_pred_part3];
        y_denom = [y_denom_part1 ; y_denom_part2 ; y_denom_part3];
%         partition_data1 = [data_part1(:,1) data_part1(:,2) y_pred_part1];
%         partition_data2 = [data_part2(:,1) data_part2(:,2) y_pred_part2];
%         partition_data3 = [data_part3(:,1) data_part3(:,2) y_pred_part3];
%        plot_data(partition_data1,partition_data2,partition_data3)
        
    end
    Rsq2_part1(i) = 1-(sum((data_part1(:,2)-y_pred_part1).^2)/sum((data_part1(:,2)-mean(y_pred_part1)).^2));
    Rsq2_part2(i) = 1-(sum((data_part2(:,2)-y_pred_part2).^2)/sum((data_part2(:,2)-mean(y_pred_part2)).^2));
    Rsq2_part3(i) = 1-(sum((data_part3(:,2)-y_pred_part3).^2)/sum((data_part3(:,2)-mean(y_pred_part3)).^2));
    cd2(i) =  1 - (sum((y_actual-y_pred).^2)./(sum(y_denom.^2)));
    
   
end
[rsq2_p1,idx_rsq2_p1] = max(Rsq2_part1);
[rsq2_p2,idx_rsq2_p2] = max(Rsq2_part2);
[rsq2_p3,idx_rsq2_p3] = max(Rsq2_part3);
[maxcd2,idx_cd2] = max(cd2);



[maxRsq,num_bp]=max([rsq0 maxcd1 maxcd2]);  %Find the number of breakpoints as per the value of Rsq or Coefficient of determination

if num_bp == 3
    best_params = params2(idx_cd2,:);    
elseif num_bp == 2
    best_params = params1(idx_cd1,:);    
else
    best_params = params0;
    disp('No breakpoint')
end

end