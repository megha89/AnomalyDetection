%%This file is Copyright (C) 2018 Megha Gaur.

function [energy_mean,temp_mean] = periodical_day_level(energy1,temp1)
%UNTITLED Summary of this function goes here
%  This function aggregates the energy and temp column periodical data into
%  day-level data.
count = 1;
j=0;
energy_day = 0;
temp_day = 0;
den_energy = 0;
den_temp = 0;
total_size = size(temp1,1);
for i = 1:total_size
    energy_value = energy1(i,1);
    if energy_value > 0
        den_energy = den_energy+1;
    end
    temp_value = temp1(i,1);
    if temp_value > 0 | temp_value < 0
        den_temp = den_temp+1;
    end
    energy_day = energy_day + energy_value;
    temp_day = temp_day + temp_value;
    count = count + 1;
    if count == 5
        j = j+1;
        if energy_day == 0 | temp_day == 0
            energy_mean(j) = 0;
            temp_mean(j) = 0;
        else
            energy_mean(j) = (energy_day/den_energy);
            temp_mean(j) = (temp_day/den_temp);
        end
        
        energy_day = 0;
        temp_day = 0;
        den_energy = 0;
        den_temp = 0;
        count = 1;
    end
end
end

