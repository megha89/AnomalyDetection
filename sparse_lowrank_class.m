 L = zeros(10);
 for i = 1:5,
     L = L + randn(10,1) * randn(1,10); 
 end
 rank(L)
 
 p = randperm(10,10)
 S = zeros(10);
for i=1:2
    S(p(1,i),:) = randn();
end
disp(S)
 
X = S+L;

% Initialization
S1 = zeros(10);

k = 50;
lambda1 = .001;
lambda2 = .001; 

S1 = zeros(10);
for i = 1:k
    [u,s,v] = svd(X-S1)
    sigma = max(0,(s-lambda1))
    L1 = u*sigma*v'
    S1 = sign(X-L1)+ max(0,abs(X-L1)>lambda2)    
end

X1 = S1+L1;
rank(L)
rank(L1)
error1 = norm(X-X1)/norm(X)
