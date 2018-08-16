%%This file is Copyright (C) 2018 Megha Gaur.

function [energy_bin, temp_bin,bin_idx] = plot_hist(sort_energy1,sort_temp1)
%Find bins (distance of 0.5) for temperature and energy
nbins = 48; %Chosen in a way that distance between two bin is maintained around 0.5

%N : no. of elements in each bin, temp_bin is the vector of bins; bin_idx gives us the index of bin to which each temp pt is assigned to.
[N,temp_bin,bin_idx] = histcounts(sort_temp1,nbins); 

%Resizing bins such that each bin has sufficient values.
i = 1;
num = nbins;
while (i < num)
    if N(1,i) > 20          %Ensures each bin to have atleast 20 points
        i = i+1;
    else
        %disp('Insufficient values, merge with next bin');
        N(1,i) = N(1,i) + N(1,i+1);  %Merging with next bin
        N = [N(1,1:i) N(1,i+2:end)] ;  %Updating elements
        %ind_bin = find(bin_idx == i+1)
        %bin_idx(ind_bin) = i
        num = num-1;
    end
end
nbins = num;
bin_idx = repelem(1:size(N,2),N)';

count = sum(N,2);

% 
[a1,centers1] = hist(sort_temp1,nbins);
%energy_bin = sort_energy1(bin_idx)

array = [bin_idx sort_energy1];  %combined bin indices from temp with energy values
[C,ia,uni_idx] = unique(array(:,1),'stable');   %
energy_bin = accumarray(uni_idx,array(:,2),[],@mean);   %Based on the values of indices, compute mean of energy values lying in the same bin
%your_mat = [C val];
temp_bin = centers1(:,1:end);
m = size(temp_bin,2);
n = size(energy_bin,1);
if m > n
    diff = m - n;
    temp_bin = centers1(:,1:end-diff);
    size(temp_bin,2);
else
    diff = n-m;    
    size(temp_bin,2);
end

% Group the elements in sort_energy on the basis of bin_idx and find the
% mean and plot them against, temp_bins.
% figure;
% plot(temp_bin,energy_bin)


end