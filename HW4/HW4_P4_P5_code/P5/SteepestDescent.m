function [x, iter, conv] = SteepestDescent(A, b, tol, maxit)
    n = size(A,1);
    x = zeros(n,1);
    normVal = Inf;
    iter = 0;
    conv = [];
    while maxit > iter && normVal > tol
        x_old = x;
        r = b - A * x;
        
        tempAr = zeros(n,1);
        tempAr(1) = A(1, 1:2) * r(1:2);
        tempAr(n) = A(n, n-1:n) * r(n-1:n);
        for i = 2:(n-1)
            tempAr(i) = A(i, i-1:i+1) * r(i-1:i+1);
        end
        
        a = r'* r / (r' * tempAr);
        x = x_old + a * r;
        
        iter = iter + 1;
        normVal = norm(x - x_old);
        conv = [conv, normVal];
    end
end