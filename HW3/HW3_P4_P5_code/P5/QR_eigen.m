function [eigVec, eigVal] = QR_eigen(A, tol)
    n = size(A, 1);
    H = A;
    for m = n:-1:2
        k = 0;
        while abs(H(m,m-1)) > tol
            k = k + 1;
            %sigma = H(m,m);
            sigma = wilkinson_shift(H);
            [Q, R] = qr(H - sigma*eye(m));
            H = R * Q + sigma * eye(m);
        end
        v(m) = H(m,m);
        H = H(1:m-1,1:m-1);
    end
    v(1) = H(1,1);
    eigVal = diag(v);
    eigVec = [];
    for lambda = v
        [val, vec, iterCount] = InverseIteration(A, (lambda + eps*50), tol);
        eigVec = [eigVec vec];
    end
end