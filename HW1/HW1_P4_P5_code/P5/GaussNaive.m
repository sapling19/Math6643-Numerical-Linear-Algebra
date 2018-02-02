function x = GaussNaive(A, b)
% A must be a n*n matrix
% b must be a n*1 vector

n = size(A,1);
x = zeros(1,n);

for k = 1:n-1
    if A(k,k) == 0
        disp('GE fails: zero division');
        return
    end
    m = -A(k+1:n,k)/A(k,k);
    A(k+1:n,:) = A(k+1:n,:) + m*A(k,:);
    b(k+1:n) = b(k+1:n) + m*b(k);
end

if A(n,n) == 0
    disp('Infinite solutions exist');
    return
end

% Backward substitution
x(n) = b(n)/A(n,n);
for k = n-1:-1:1
    x(k) = (b(k) - dot(A(k,k+1:n),x(k+1:n)))/A(k,k);
end