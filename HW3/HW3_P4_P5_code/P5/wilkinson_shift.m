function u = wilkinson_shift(A)
    n = size(A,1);
    if A == diag(diag(A))
        u = A(n,n);
        return
    end
    a = A(n,n); b = A(n,n-1);
    s = (A(n-1,n-1)-a)/2;
    if s ~= 0
        sn = sign(s);
    else
        sn = 1;
    end
    u = a - sn*b^2/(abs(s) + sqrt(s^2+b^2));