function [S, L] = L1NN(y, F, W, sizeImage, beta, err, alpha, c)

% algorithm for solving the following optimization problem
% min nuclear_norm(L) + beta*||W(S)||_1
% subject to ||y-F(S+L)|_2 < err
% This is a generalized version of Pricipal Component Pursuit (PCP) where
% the sparsity is assumed in a transform domain and not in measurement
% domain. Moreover the samples obtained are lower dimensional projections.

% Inputs
% y - observation (lower dimensional projections)
% F - projection from signal domain to observation domain
% W - transform where the signal is sparse
% sizeImage - size of matrix or image
% beta - term balancing sparsity and rank deficiency
% err - related to noise variance
% alpha - maximum eigenvalue of F'F
% c - maximum eigenvalue of W'W
% Outputs
% S - sparse component
% L - low rank component

decfac = 0.5;
tol = 1e-4;
insweep = 50;
% p = 0.5; q = 0.5;

if nargin < 6
    err = 1e-6;
end
if nargin < 7
    alpha = 1;
end
if nargin < 8
    c = 1;
end

L = zeros(sizeImage); % Low rank component
S = zeros(sizeImage); % Sparse component
sl = zeros(prod(sizeImage),1);
z = W(S(:),1);

lambdaInit = decfac*max(abs(F(y,2))); lambda = lambdaInit;

Sigma = svd(L);
f_current = norm(y-F(S(:)+L(:),1)) + lambda*beta*norm(W(S(:),1),1) + lambda*norm(diag(Sigma),1);

lambdaInit = decfac*max(abs(F(y,2))); lambda = lambdaInit;

while lambda > lambdaInit*tol
    % lambda % for checking progress
    for i = 1:insweep
        f_previous = f_current;
   
        % Landweber update
        sl = sl + (1/alpha)*F(y-F(S(:)+L(:),1),2);
   
        % Updating sparse component
        stilde = sl - L(:);
        z = (c*z + W(stilde-W(z,2),1))./(((2*alpha)/(beta*lambda))*abs(W(stilde,1))+c); % L1 Minimization
%         z = (c*z + W(stilde-W(z,2),1))./(((2*alpha)/(beta*lambda))*abs(W(stilde,1)).^(2-q)+c);
        s = stilde - W(z,2);
        S = reshape(s,sizeImage);
   
        % Updating low rank component
        ltilde = sl-S(:);
        [U,Sigma,V] = svd(reshape(ltilde,sizeImage));
        Sigma = sign(diag(Sigma)).*max(0,abs(diag(Sigma))-lambda/(2*alpha)); % Nuclear Norm Minimization
%         Sigma = sign(diag(Sigma)).*max(0,abs(diag(Sigma))-abs(diag(Sigma).^(p-1)).*lambda/(2*alpha)); % Schatten p-norm Minimization
        L = U*diag(Sigma)*V';
   
        f_current = norm(y-F(S(:)+L(:),1)) + lambda*beta*norm(W(S(:),1),1) + lambda*norm(Sigma,1);
   
        if norm(f_current-f_previous)/norm(f_current + f_previous)<tol
            break;
        end
    end
   
    if norm(y-F(S(:)+L(:),1))<err
        break;
    end
    lambda = decfac*lambda;
end