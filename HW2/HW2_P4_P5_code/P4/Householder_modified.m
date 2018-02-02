function [Q, R] = Householder_modified(A, p)
% A must be a n*n matrix
% p: lower bandwidth

[n, n] = size(A);
U = zeros(n,n);
Q = zeros(n,n);
R = A;

for k = 1:n-p-1
    x = R(k:p+k,k);
    e = zeros(p+1,1); e(1) = 1;
    v = sign(x(1))*norm(x,2)*e + x;
    v = v / norm(v,2);
    R(k:k+p,k:n) = R(k:k+p,k:n) - 2*v*v'*R(k:k+p,k:n);
    U(k:k+p,k) = v; % Store reflection vectors for later use
end

for k = n-p:n
    x = R(k:n,k);
    e = zeros(n-k+1,1); e(1) = 1;
    v = sign(x(1))*norm(x,2)*e + x;
    v = v / norm(v,2);
    R(k:n,k:n) = R(k:n,k:n) - 2*v*v'*R(k:n,k:n);
    U(k:n,k) = v; % Store reflection vectors for later use
end

% Constructing Q based on the matrix U
% Algorithm 10.3 is used
%for j = 1:n
%    u = zeros(n,1); u(j) = 1;
%    for k = n:-1:1
%        u(k:n) = u(k:n) - 2*U(k:n,k)*U(k:n,k)'*u(k:n);
%    Q(:,j) = u;
%    end
%end