U = randn(50,2); V = randn(2,50);
L = U*V % generate model
S = randn(50,50) > 0.98; % generate anomaly
S = +S
X = S + L % generate data

F = opDirac(numel(X)); W = opDirac(numel(X)); % operators for PCP
[S1, L1] = L1NN(X(:), F, W, [50 50], .1);
norm(L-L1,'fro')/norm(L,'fro') % check the recovery error for low-rank (model)
norm(S-S1,'fro')/norm(S,'fro') % check recovery error for sparse (anomaly)