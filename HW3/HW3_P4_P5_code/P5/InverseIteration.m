function [lambda, v, iterCount] = InverseIteration(A, u, tol)
    n = size(A, 1);
    %v = randn(n, 1); v = v / norm(v);
    v = [1; zeros(n-1,1)];
    oldLambda = 0;
    iterCount = 0;
    while 1
        iterCount = iterCount + 1;
        w = (A - u * eye(n)) \ v;
        v = w / norm(w);
        lambda = v' * A * v;
        if abs(lambda - oldLambda) < tol
            break
        else
            oldLambda = lambda;
        end
    end
end