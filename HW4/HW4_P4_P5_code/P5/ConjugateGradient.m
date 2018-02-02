function [x, iter, conv] = ConjugateGradient(A, b, tol, maxit)
    n = size(A,1);
    x = zeros(n,1);
    r = b - A * x;
    p = r;
    normVal = Inf;
    iter = 0;
    conv = [];
    while maxit > iter && normVal > tol
        x_old = x; r_old = r; p_old = p;
        
        tempAp_old = zeros(n,1);
        tempAp_old(1) = A(1, 1:2) * p_old(1:2);
        tempAp_old(n) = A(n, n-1:n) * p_old(n-1:n);
        for i = 2:(n-1)
            tempAp_old(i) = A(i, i-1:i+1) * p_old(i-1:i+1);
        end
        
        a = r_old'* r_old / (p_old' * tempAp_old);
        x = x_old + a * p_old;
        r = r_old - a * tempAp_old;
        t = r' * r / (r_old' * r_old);
        p = r + t * p_old;
        
        iter = iter + 1;
        normVal = norm(x - x_old);
        conv = [conv, normVal];
    end
end