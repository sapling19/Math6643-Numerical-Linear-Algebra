function [Q, R] = ModifiedGS(A)

[m, n] = size(A);
Q = zeros(m,n);
R = zeros(m,n);

for j = 1:n
    R(j,j) = norm(A(:,j),2);
    Q(:,j) = A(:,j) / R(j,j);
    for k = j+1:n
        R(j,k) = Q(:,j)'*A(:,k);
        A(:,k) = A(:,k) - R(j,k)*Q(:,j);
    end
end