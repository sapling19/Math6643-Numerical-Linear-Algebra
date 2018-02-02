function [Q, R] = ClassicalGS(A)

[m, n] = size(A);
Q = zeros(m,n);
R = zeros(m,n);

for j = 1:n
    v = A(:,j);
    for k = 1:j-1
        R(k,j) = Q(:,k)'*A(:,j);
        v = v - R(k,j)*Q(:,k);
    end
    R(j,j) = norm(v,2);
    Q(:,j) = v / R(j,j);
end