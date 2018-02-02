function [x, iters, conv] = jacobi(A, b, tol)
    x = zeros(size(b));
    n = size(A, 1);
    D = diag(diag(A));
    E = D - tril(A);
    F = D - triu(A);
    
    normVal = Inf;
    iters = 0;
    conv = [];
    while normVal > tol
        x_old = x;
        x = D \ (b + (E + F) * x_old);
        normVal = norm(x - x_old);
        iters = iters + 1;
        conv = [conv, normVal];
    end
end

%{
function x = jacobi(A, b, tol)
    x = zeros(size(b));
    n = size(A, 1);
    normVal = Inf;
    while normVal > tol
        x_old = x;
        for i = 1:n
            x(i) = (b(i) - A(i,1:i-1) * x_old(1:i-1) - A(i,i+1:n) * x_old(i+1:n)) / A(i,i);
        end
        normVal = norm(x - x_old);
    end
end
%}