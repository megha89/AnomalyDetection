function [point1,point2] = max_change_slope(temp_bin1,energy_bin1)
temp_bin1 = temp_bin1';
temp_bin1 = temp_bin1(20:end,:);
energy_bin1 = energy_bin1(20:end,:);
smooth_energy1 = smooth(energy_bin1);
n = size(temp_bin1,1);
slope(1,1) = smooth_energy1(1,1)/temp_bin1(1,1);
for i = 2:n
    slope(i,1) = smooth_energy1(i,1)./temp_bin1(i,1);
    change_slope(i-1,1) = slope(i-1,1) - slope(i,1);
end
for j = 1:size(change_slope,1)-1
    second_change_slope(j,1) = change_slope(j+1,1) - change_slope(j,1);
end

plot(temp_bin1, energy_bin1,'o-')
hold on;
plot(temp_bin1, smooth_energy1,'o-')
hold off;
xlabel('Temperature')
ylabel('Energy')
legend('actual','after smoothing')
%title('Year: June 12 to May 13')
[min_first_change,idx1] = min(abs(change_slope));
[min_second_change,idx2] = min(abs(second_change_slope));
[sort_values1,sort_idx1] = sort(abs(change_slope),'ascend');
[sort_values2,sort_idx2] = sort(abs(second_change_slope),'ascend');
point1 = idx2;
point2 = idx1;


end
