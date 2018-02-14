% Calculates the most anomolous days and their score in the each month(april and may) individually of different houses(9 houses). The
% threshold is set as greater than 75%.The result cell array for every
% house contains two cell values each containg the anomolous days in a month.

%To run the code, change the dataset(weekday/weekend type), day string(no
%of houses), '�' value(count of houses), name of the saved result matrix.

clc; clear all;
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_house_matrix/
addpath C:\Users\mgaur\Documents\MATLAB\AnomalyDetection\Matrices\Pecan_weekday_house_mat
%addpath C:\Users\mgaur\Documents\MATLAB\AnomalyDetection\Matrices\Pecan_weekend_house_mat
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_weekday_app_mat
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_weekend_app_mat
%addpath /Users/meghagupta/Documents/MATLAB/AnomalyDetection/Matrices/Pecan_house_app_mat/
addpath C:\Users\mgaur\Documents\MATLAB\AnomalyDetection\sparco-1.2
addpath C:\Users\mgaur\Documents\MATLAB\AnomalyDetection\FastRPCA_Stephen\solvers



for n = 1
    k = 1;    
    for i = 1
        
        %days_string = {'1','2','3','4','5','8','11','12','14','16'};
        days_string = {'1'};
        formatSpec1 = 'House%s.mat';
        A1 = days_string{i};
        str = sprintf(formatSpec1,A1);
        house_data = load(str);
        house_fields = fieldnames(house_data);
        
        for j = 1:numel(house_fields)
            disp(house_fields{j})
            X = house_data.(house_fields{j});
            rows_data = size(X,1);
            col_data = size(X,2);
            
            figure(j);
            title('Original Data')
            
            max_y = max(X(:));
            y = linspace(0,max_y);
            C = {'k','b','r','g','m','k','b','r','g','m','k','b','r','g','m','k','b','r','g','m','k','b','r','g','m','k','b','r','g','m','k','b','r','g','m'};
            %C = {'k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b','k','b'};
            %days = [7,8,9,10,11,12,29,30];
            for k = 1:col_data
                %for k = 1:8
                subplot(5,5,k)
                plot(X(:,k),'Color', C{k})
                %plot(X(:,k),'-ok')
                ylim([0 max_y])
                
            end
        
         end
%         
     end
%    
   % score_mat = reshape(cell2mat(Score_norm),[24,22]);
    
   %disp(result)
   %disp(score)
 %  formatSpec2 = 'RPCA_lamda_ac%d.mat';
   %formatSpec3 = 'result%d';
 %  A2 = n;
   %A2 = lambda;
 %  result_mat = sprintf(formatSpec2,A2);
   %result_var = sprintf(formatSpec3,A2);
   %R.(result_var) = result;
 %  save(result_mat,'result','score');
    %save(result_mat,'-struct','R');
 %   save('RPCA_weekday279.mat','result','score');
    %k=1;

    
% %Plot aggregate consumption pattern for different days per hour

end

% figure(3);
% clf;
% C = {'k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c'};
%
% for i = 1:rows_data
%  % plot(L(i,:), 'Color', C{i})
%   hold on;
% end
%
% xlabel('Hours')
% ylabel('Energy consumed')
% title('Low Rank component')
%
% %figure(2);
% clf;
% C = {'k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c','k','b','r','g','m','c'};
%
% for i = 1:rows_data
%   %plot(S(i,:), 'Color', C{i})
%   hold on;
% end
%
% xlabel('Hours')
% ylabel('Energy consumed')
% title('Sparse component')

%legend('Day1','Day2','Day3','Day4','Day5','Day6','Day7','Day8','Day9','Location','northwest');


% MAX = Score(1,1);
% for i = 1:size(Score,1)
%     for j = 1:size(Score,2)
%         max_temp = max(Score(i,j));
%         if max_temp > MAX
%             MAX = max_temp;
%         end
%     end
% end
% disp(MAX)
%MAX = max(Score(:));



% %NORMALIZE THE DATA
% for i = 1:col_data
%     min_val = min(Score_day(:,i));
%     max_val = max(Score_day(:,i));
%     col(:,i) = (Score_day(:,i) - min_val)/(max_val - min_val);
%
% end
% disp('NORMALIZED DATA')










% F = opDirac(numel(X)); W = opDirac(numel(X)); % operators for PCP
% [S1, L1] = L1NN(X(:), F, W, [5 5], .1);
% S_rpca = mean(S1,1);
% L_rpca = mean(L1,1);
% 
% % Reading the Kalman smoothed values from csv file.
% sheet1 = 6;
% xlRange1 = 'A2:B76';
% X_kalman = xlsread(filename,sheet1,xlRange1);
% L_kalman = X_kalman(:,1);
% X_mean = mean(X,1)
% S_kalman = X_mean' - L_kalman;
% 
% %Plot Low ranked component from RPCA vs Low ranked from Kalman
% figure(2);
% clf;
% plot(L_rpca','r-');
% hold on;
% plot(L_kalman,'b-');
% legend('Low Rank RPCA','Low Rank Kalman');
% 
% %Plot sparse component from RPCA vs sparse component from Kalman
% figure(3)
% clf;
% plot(S_rpca','r-')
% hold on;
% plot(S_kalman,'b-')
% legend('Sparse RPCA','Sparse Kalman');
% 
% % Recovery error for low ranked and sparse component
% norm(L_kalman-L_rpca','fro')/norm(L_kalman,'fro') % check the recovery error for low-rank (model)
% norm(S_kalman-S_rpca','fro')/norm(S_kalman,'fro') % check recovery error for sparse (anomaly)
