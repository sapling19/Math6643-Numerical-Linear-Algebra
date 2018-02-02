function x = GaussPP(A,b)
% A must be a n*n matrix
% b must be a n*1 vector

n = size(A,1);
x = zeros(1,n);
A = [A,b];      % Augmented matrix

for k = 1:n-1
    % Diagonal entries are always largest after exchanges
    for j = k+1:n
        if abs(A(j,k)) > abs(A(k,k))
            temp = A(k,:);
            A(k,:) = A(j,:);
            A(j,:) = temp;        
        end
    end

    if A(k,k) == 0 % Zero entries at diagonal and below
        disp('Infinite solutions exist');
        return
    end
    
    m = -A(k+1:n,k)/A(k,k);
    A(k+1:n,:) = A(k+1:n,:) + m*A(k,:);
end

if A(n,n) == 0
    disp('Infinite solutions exist');
    return
end

%backward substitution
x(n) = A(n,n+1)/A(n,n);
for k = n-1:-1:1
    x(k) = (A(k,n+1) - dot(A(k,k+1:n),x(k+1:n)))/A(k,k);
end