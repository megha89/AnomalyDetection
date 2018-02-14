function [train, validation] = split_data(temp,energy)
m = size(temp,1);
n = floor(m/10);
count = 0;
%validation_idx = []
while (count < n)
    %for i = 1:10
        %start_idx = i;
        i = count+1;
        end_idx = 10;
        random_indices = randperm(end_idx);
        %validat_idx = 5 + (count*end_idx)
        validation_idx(i) = random_indices(1)+(count*end_idx);
        count = count+1;
    %end
end
train_idx = setdiff(1:m,validation_idx);
train = [temp(train_idx) energy(train_idx)];
validation = [temp(validation_idx) energy(validation_idx)];
end