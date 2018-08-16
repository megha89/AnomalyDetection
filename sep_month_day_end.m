%%This file is Copyright (C) 2018 Megha Gaur.

function [weekday,weekend]= sep_month_day_end(data)
col = size(data,2);
month = [1:1:30];
april_weekend_days = [5,6,12,13,19,20,26,27];
april_weekday_days = setdiff(month,april_weekend_days);
may_weekend_days = [3,4,10,11,17,18,24,25];
may_weekday_days = setdiff(month,may_weekend_days);
april_col = [1:2:col];
may_col = [2:2:col];
weekday_april_data = data(april_weekday_days,april_col);
weekday_may_data = data(may_weekday_days,may_col);
weekend_april_data = data(april_weekend_days,april_col);
weekend_may_data = data(may_weekend_days,may_col);

weekday = weekday_may_data(:,[1;1]*(1:size(weekday_may_data,2)));
weekday(:,1:2:end) = weekday_april_data;
weekend = weekend_may_data(:,[1;1]*(1:size(weekend_may_data,2)));
weekend(:,1:2:end) = weekend_april_data;

end