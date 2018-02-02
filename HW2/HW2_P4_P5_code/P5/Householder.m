function [Q, R] = Householder(A)

[m, n] = size(A);
U = zeros(m,n);
Q = zeros(m,n);
R = A;

for k = 1:n
    x = R(k:m,k);
    e = zeros(m-k+1,1); e(1) = 1;
    v = sign(x(1))*norm(x,2)*e + x;
    v = v / norm(v,2);
    R(k:m,k:n) = R(k:m,k:n) - 2*v*v'*R(k:m,k:n);
    U(k:m,k) = v; % Store reflection vectors for later use
end

% Constructing Q based on the matrix U
% Algorithm 10.3 is used
for j = 1:n
    u = zeros(m,1); u(j) = 1;
    for k = n:-1:1
        u(k:m) = u(k:m) - 2*U(k:m,k)*U(k:m,k)'*u(k:m);
    Q(:,j) = u;
    end
end