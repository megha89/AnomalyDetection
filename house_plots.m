%%This file is Copyright (C) 2018 Megha Gaur.

clc; clear all;
%Plot aggregate consumption pattern for different days per hour

%addpath C:\Users\Angshul\Documents\MATLAB\AnomalyDetection\Peccan_house_matrix
%addpath C:\Users\Angshul\Documents\MATLAB\AnomalyDetection\Pecan_weekday_house_mat
%addpath C:\Users\Angshul\Documents\MATLAB\AnomalyDetection\Pecan_house_app_mat\
%addpath C:\Users\Angshul\Documents\MATLAB\AnomalyDetection\Matrices\Pecan_weekday_app_mat
addpath C:\Users\Angshul\Documents\MATLAB\AnomalyDetection\Matrices\Pecan_weekend_app_mat


for i = 10:10
    days_string = {'1','2','3','4','5','8','11','12','14','16'};
    formatSpec1 = 'House%s_fridge.mat';
    A1 = days_string{i};
    str = sprintf(formatSpec1,A1)
    house_data = load(str);
    house_fields = fieldnames(house_data);
    
    for j = 1:numel(house_fields)
        disp(house_fields{j})
        X = house_data.(house_fields{j});
        rows_data = size(X,1);
        col_data = size(X,2);
        
         figure(j);
         clf;
         title('Original Data')
         
         max_y = max(X(:));
         y = linspace(0,max_y);
         C = {'k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c'};
         
         for k = 1:col_data
             subplot(6,6,k)
             plot(X(:,k), 'Color', C{k})
             ylim([0 max_y])
             
         end
        


    end
end

    


