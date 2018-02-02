function [x, iters, conv] = SOR(A, b, w, tol)
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
        x = (D - w * E) \ (w * b + ((1 - w) * D + w * F) * x_old);
        normVal = norm(x - x_old);
        iters = iters + 1;
        conv = [conv, normVal];
    end
end