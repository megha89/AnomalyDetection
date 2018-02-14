function [result1] = conv_end_mon(result)

row = size(result,1);
col = size(result,2);
true_day = [];

%APRIL
for i = 1:2:col
    num = numel(result{1,i});
    for j = 1:num
        temp = result{1,i}(j,1);
        if temp <= 2
            true_day{1,i}(j,1) = temp+4;
        elseif temp <= 4
            true_day{1,i}(j,1) = temp+9;
        elseif temp <= 6
            true_day{1,i}(j,1) = temp+14;
        else temp <= 8
            true_day{1,i}(j,1) = temp+19;      
        end
    end
end

%MAY
for i = 2:2:col
    num = numel(result{1,i});
    for j = 1:num
        temp = result{1,i}(j,1);
       if temp <= 2
            true_day{1,i}(j,1) = temp+2;
        elseif temp <= 4
            true_day{1,i}(j,1) = temp+7;
        elseif temp <= 6
            true_day{1,i}(j,1) = temp+12;
        else temp <= 8
            true_day{1,i}(j,1) = temp+17;
        end
    end
end
result1 = true_day;
end