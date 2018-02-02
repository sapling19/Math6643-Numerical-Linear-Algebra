function [lambda, v, iterCount] = PowerIteration(A, tol)
    n = size(A, 1);
    rng(1);
    v = randn(n, 1); v = v / norm(v);
    %v = zeros(n,1); v(1) = 1;
    oldLambda = 0;
    iterCount = 0;
    while 1
        iterCount = iterCount + 1;
        w = A * v;
        v = w / norm(w);
        lambda = v' * A * v;
        if abs(lambda - oldLambda) < tol
        %if iterCount > 2000
            break
        else
            oldLambda = lambda;
        end
    end
end