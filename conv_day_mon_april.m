function [result1] = conv_day_mon_april(result)
%This function converts the order of the weekdays in the month of April
%(from serial to the proper month order).
%RPCA 
%load('rpca_data_result.mat','score','result')
row = size(result,1);
col = size(result,2);
true_day = [];

%APRIL
for i = 1:col
    num = numel(result{1,i});
    for j = 1:num
        temp = result{1,i}(j,1);
        if temp <= 4
            true_day{1,i}(j,1) = temp;
        elseif temp <= 9
            true_day{1,i}(j,1) = temp+2;
        elseif temp <= 14
            true_day{1,i}(j,1) = temp+4;
        elseif temp <= 19
            true_day{1,i}(j,1) = temp+6;
        elseif temp <= 22
            true_day{1,i}(j,1) = temp+8;
        elseif temp <= 24
            true_day{1,i}(j,1) = temp-18;
        elseif temp <= 26
            true_day{1,i}(j,1) = temp-13;
        elseif temp <= 28
            true_day{1,i}(j,1) = temp-8;
        else temp <= 30
            true_day{1,i}(j,1) = temp-3;
        end
    end
end
result1 = true_day;
end
%MAY
% for i = 1:col
%     num = numel(result{1,i})
%     for j = 1:num
%         temp = result{1,i}(j,1)
%         if temp <= 2
%             true_day{1,i}(j,1) = temp;
%         elseif temp <= 7
%             true_day{1,i}(j,1) = temp+2;
%         elseif temp <= 12
%             true_day{1,i}(j,1) = temp+4;
%         elseif temp <= 17
%             true_day{1,i}(j,1) = temp+6;
%         elseif temp <= 22
%             true_day{1,i}(j,1) = temp+8;
%         elseif temp <= 24
%             true_day{1,i}(j,1) = temp-20;
%         elseif temp <= 26
%             true_day{1,i}(j,1) = temp-15;
%         elseif temp <= 28
%             true_day{1,i}(j,1) = temp-10;
%         else temp <= 30
%             true_day{1,i}(j,1) = temp-5
%         end
%     end
% end
% result1 = true_day;
% end
%save('rpca_daytype_result.mat','result','score')

%SEEM
%load('seem_daytype.mat','seem_score','seem_result')

% row = size(seem_result,1)
% col = size(seem_result,2)
% weekday = seem_result(1:10,:)
% day_row = size(weekday,1)
% weekend = seem_result(11:end,:)
% end_row = size(weekend,1)
% true_weekday = [];
% true_weekend = [];
% 
% %For April weekdays
% for j = 1:2:col
%     for i = 1:day_row
%         temp = weekday(i,j)    
%         if temp <= 4
%             true_weekday(i,j) = temp;
%         elseif temp <= 9
%             true_weekday(i,j) = temp+2;
%         elseif temp <= 14
%             true_weekday(i,j) = temp+4;
%         elseif temp <= 19
%             true_weekday(i,j) = temp+6;
%         else temp <= 22
%             true_weekday(i,j) = temp+8;
%         end
%     end
% end
% %For May weekdays
% for j = 2:2:col
%     for i = 1:day_row
%         temp = weekday(i,j)    
%         if temp <= 2
%             true_weekday(i,j) = temp;
%         elseif temp <= 7
%             true_weekday(i,j) = temp+2;
%         elseif temp <= 12
%             true_weekday(i,j) = temp+4;
%         elseif temp <= 17
%             true_weekday(i,j) = temp+6;
%         else temp <= 22
%             true_weekday(i,j) = temp+8;
%         end
%     end
% end
% 
% % For April Weekend
% for j = 1:2:col
%     for i = 1:end_row
%         temp = weekend(i,j)    
%         if temp <= 2
%             true_weekend(i,j) = temp+4;
%         elseif temp <= 4
%             true_weekend(i,j) = temp+9;
%         elseif temp <= 6
%             true_weekend(i,j) = temp+14;
%         else temp <= 8
%             true_weekend(i,j) = temp+19;
%         end
%     end
% end
% 
% %For May weekend
% for j = 2:2:col
%     for i = 1:end_row
%         temp = weekend(i,j)    
%         if temp <= 2
%             true_weekend(i,j) = temp+2;
%         elseif temp <= 4
%             true_weekend(i,j) = temp+7;
%         elseif temp <= 6
%             true_weekend(i,j) = temp+12;
%         else temp <= 8
%             true_weekend(i,j) = temp+17;
%         end
%     end
% end
