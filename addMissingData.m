%%This file is Copyright (C) 2018 Megha Gaur.

function [added_data] = addMissingData(data)
%This function adds the missing energy consumption data by looking up the
%data values for the same timestamp in next or previous year

m = size(data,1);
%Check if there is an empty cell.
timestamp =  table2array(data(:,1));
hour = table2array(data(:,2));
energy = table2array(data(:,3));
temp = table2array(data(:,4));
row_idx = find(isnan(energy));
timestamp_empty = timestamp(row_idx);
hour_empty = hour(row_idx);

final_idx = zeros(length(row_idx),1);
for i = 1:size(row_idx,1)
    
    if m > (8760 + row_idx(i,1))
        
        timestamp_new = datetime(timestamp_empty,'InputFormat','dd/MM/yy')+calmonths([12]);
        timestamp_new = cellstr(datetime(timestamp_new,'Format','dd/MM/yy'));
        rows_new = find(ismember(timestamp, timestamp_new{i,1}));
        final_idx(i) = rows_new(hour(rows_new) == hour_empty(i,1));
    else
        timestamp_new = datetime(timestamp_empty,'InputFormat','dd/MM/yy') - calmonths([12]);
        timestamp_new = cellstr(datetime(timestamp_new,'Format','dd/MM/yy'));
        rows_new = find(ismember(timestamp, timestamp_new{i,1}));
        final_idx(i) = rows_new(hour(rows_new) == hour_empty(i,1));
    end    
end

energy(row_idx) = energy(final_idx);

if find(isnan(energy))
    row_idx = find(isnan(energy));
    timestamp_empty = timestamp(row_idx);
    timestamp_new = datetime(timestamp_empty,'InputFormat','dd/MM/yy') - 2*(calmonths([12]));
    timestamp_new = cellstr(datetime(timestamp_new,'Format','dd/MM/yy'));
    for j = 1:length(row_idx)
        rows_new = find(ismember(timestamp, timestamp_new{j,1}));
        if rows_new
            final_idx = rows_new(hour(rows_new) == hour_empty(i,1));
            energy(row_idx(j)) = energy(final_idx);
        end
    end
end
energy(row_idx) = energy(final_idx);

added_data = table(timestamp, hour, energy, temp);
end




