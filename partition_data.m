function [partition_data1,partition_data2,partition_data3,coeff_deter] = partition_data(temp_mean,energy_mean,best_params)

%   This function partitions the energy and temperature columns based on
%   the breakpoints and plot the predicted energy vs actual energy.

n = length(best_params);
energy_temp_mat = [temp_mean energy_mean];

if n == 8
    %min_temp = 8.2;     %8.5
    %temp_mean_mid1 = 14.5;  %15.5
    
    idx_part1 = find(energy_temp_mat(:,1) <= best_params(1,1));
    temp_part1 = temp_mean(idx_part1);
    energy_part1 = energy_mean(idx_part1);
    x_part1 = [ones(length(energy_part1),1) energy_part1(:,1)];
    y_pred_part1 = x_part1 * best_params(1,3:4)';
    
    idx_part2 = find(energy_temp_mat(:,1)>best_params(1,1) & energy_temp_mat(:,1)<= best_params(1,2));
    temp_part2 = temp_mean(idx_part2);
    energy_part2 = energy_mean(idx_part2);
    x_part2 = [ones(length(energy_part2),1) energy_part2];
    y_pred_part2 = x_part2 * best_params(1,5:6)';
    
    idx_part3 = find(energy_temp_mat(:,1)>best_params(1,2));
    temp_part3 = temp_mean(idx_part3);
    energy_part3 = energy_mean(idx_part3);
    x_part3 = [ones(length(energy_part3),1) energy_part3];
    y_pred_part3 = x_part3 * best_params(1,7:8)';
    
    partition_data1 = [temp_part1 energy_part1 y_pred_part1]; 
    partition_data2 = [temp_part2 energy_part2 y_pred_part2];
    partition_data3 = [temp_part3 energy_part3 y_pred_part3];
    y_actual = [energy_part1 ; energy_part2 ; energy_part3];
    y_pred = [y_pred_part1 ; y_pred_part2 ; y_pred_part3];
    y_denom_part1 = energy_part1 - mean(energy_part1);
    y_denom_part2 = energy_part2 - mean(energy_part2);
    y_denom_part3 = energy_part3 - mean(energy_part3);
    y_denom = [y_denom_part1 ; y_denom_part2 ; y_denom_part3];
    coeff_deter =  1 - ((sum((y_actual-y_pred).^2))./(sum(y_denom.^2)));
    
elseif n == 5
    
    idx_part1 = find(energy_temp_mat(:,1) <= best_params(1,1));
    temp_part1 = temp_mean(idx_part1);
    energy_part1 = energy_mean(idx_part1);
    x_part1 = [ones(length(energy_part1),1) energy_part1(:,1)];
    y_pred_part1 = x_part1 * best_params(1,2:3)';
    
    idx_part2 = find(energy_temp_mat(:,1)>best_params(1,1));
    temp_part2 = temp_mean(idx_part2);
    energy_part2 = energy_mean(idx_part2);
    x_part2 = [ones(length(energy_part2),1) energy_part2(:,1)];
    y_pred_part2 = x_part2 * best_params(1,4:5)';
    
    partition_data1 = [temp_part1 energy_part1 y_pred_part1];
    partition_data2 = [temp_part2 energy_part2 y_pred_part2];
    partition_data3 = 0;
    y_actual = [energy_part1 ; energy_part2];
    y_pred = [y_pred_part1 ; y_pred_part2];
    y_denom_part1 = energy_part1 - mean(energy_part1);
    y_denom_part2 = energy_part2 - mean(energy_part2);
    y_denom = [y_denom_part1 ; y_denom_part2 ];
    coeff_deter =  1 - (sum((y_actual-y_pred).^2)./(sum(y_denom.^2)));
   
else
    
    x = [ones(length(energy_mean),1) energy_mean(:,1)];
    y_pred = x*best_params;
    partition_data1 = [temp_mean energy_mean y_pred];
    partition_data2 = 0;
    partition_data3 = 0;   
    coeff_deter =  1 - (sum((energy_mean-y_pred).^2)./(sum((energy_mean-mean(energy_mean)).^2)));
    
end

%plot_data(partition_data1,partition_data2,partition_data3)

end

