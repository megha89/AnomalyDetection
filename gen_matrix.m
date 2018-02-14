clc; clear all;
%addpath C:\Users\Angshul\Documents\MATLAB\AnomalyDetection\Peccan_dataset
addpath C:\Users\mgaur\Documents\MATLAB\MetricEvaluation\Dataset
filepath = 'C:\Users\mgaur\Documents\MATLAB\MetricEvaluation\Dataset\Electricity_P';
%filepath = 'C:\Users\Angshul\Documents\MATLAB\AnomalyDetection\test';
filename = dir(fullfile(filepath,'*.csv'));
files = {filename.name}';   %'# file names
num = numel(files);
hourly_meter_data = 0;
count = 1;
col = 0;

for i = 5:5
    str = (files{i});
    filename = fullfile(filepath,str);
    fileID = fopen(filename,'r');
    %F = textscan(fileID,'%s %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %f %*[^\n]','Delimiter',{',';'\n'},'HeaderLines',1);
    F = textscan(fileID,'%s %*f %*f %*f %*f %*f %*f %*f %*f %f %*[^\n]','Delimiter',{',';'\n'},'HeaderLines',1);
    timestamp = F{1};
    fridge_data = F{2};
    k = 0;

 %Check for files with 1 month of data
    rows = size(timestamp,1)
    no_months = round((rows/1440)/30);
    col = col+1;
    IndexS = strfind(timestamp,'2014-04-01 00:00:00-05:00');
    IndexE = strfind(timestamp,'2014-05-30 23:59:00-05:00');
    Index1 = find(not(cellfun('isempty', IndexS)));
    Index2 = find(not(cellfun('isempty', IndexE)));
        for j = Index1:Index2
            [date] = strsplit(timestamp{j,:});
            [DayNumber,DayName] = weekday(date{1});
            %if DayName == 'Mon' | DayName == 'Tue' | DayName == 'Wed' | DayName == 'Thu' | DayName == 'Fri'
            if DayName == 'Sat' | DayName == 'Sun'
            if count <= 60
                hourly_meter_data = hourly_meter_data + fridge_data(j,:);
                agg_meter_data = floor(hourly_meter_data/(count));
                %k = k+1;
                %weekend_data{k,col} = agg_meter_data;
                count = count+1;
                if count == 61
                    k = k+1;
                    appliance_data{k,col} = agg_meter_data;
                    count = 1;
                    hourly_meter_data = 0;
                end

            else
                k = k+1;                    
                if j > 60
                    hourly_timestamp = timestamp{j-60,:};
                    %  weekend_data{k,col} = hourly_timestamp;
                    appliance_data{k,col} = agg_meter_data;
                    count = 1;
                    hourly_meter_data = 0;
                else
                    hourly_timestamp = timestamp{j,:};
                    %weekend_data{k,col} = hourly_timestamp;
                    appliance_data{k,col} = agg_meter_data;
                    count = 1;
                    hourly_meter_data = 0;
                end
            end
            end
        end
        disp(filename)
        
end
        fclose(fileID);
        
        %save('fridge_data.mat','appliance_data')
        
%  
% % fileID = fopen('weekendData1.dat','w');
% % formatSpec = '%s %d\n';
% % [nrows,ncols] = size(weekend_data);
% % for row = 1:nrows
% %     fprintf(fileID,formatSpec,weekend_data{row,:});
% % end
% % fclose(fileID);
% 
