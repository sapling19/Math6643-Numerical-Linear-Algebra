u_lambda_0 = @(x)(-0.5 * x^3 + 0.25 * x^2 - 1.75 * x);
u_lambda_2 = @(x)(((exp(sqrt(2)) + 13)*exp(-sqrt(2) * x) - (exp(-sqrt(2)) + 13)*exp(sqrt(2) * x))/(4*(exp(sqrt(2)) - exp(-sqrt(2)))) + 1.5*x - 0.25);
%u_lambda_2 = @(x)(3*x)/2 - (exp(2^(1/2)*x)*(13*exp(2^(1/2)) + 1))/(4*(exp(2*2^(1/2)) - 1)) + (exp(-2^(1/2)*x)*exp(2^(1/2))*(exp(2^(1/2)) + 13))/(4*(exp(2*2^(1/2)) - 1)) - 1/4;
tol = 1e-12; maxit = 1e7;
for lambda = [0, 2]
    SD_time = []; CG_time = [];
    nlist = [100, 200, 400, 800, 1600, 3200];
    for n = nlist
        disp(n)
        h = 1 / (n+1);
        A = zeros(n); b = zeros(n, 1);
        for k = 1:n
            if k > 1
                A(k, k-1) = 1;
            end
            A(k, k) = -(2 + lambda * h^2);
            if k < n
                A(k, k+1) = 1;
            end
            b(k) = 0.5 * h^2 - 3 * k * h^3;
        end
        b(n) = b(n) + 2;
        
        tic
        [u_SD, iter_SD, conv_SD] = SteepestDescent(A, b, tol, maxit);
        t = toc;
        SD_time = [SD_time, t];
        
        tic;
        [u_CG, iter_CG, conv_CG] = ConjugateGradient(A, b, tol, maxit);
        t = toc;
        CG_time = [CG_time, t];
        
        if lambda == 0
            y_exact = u_lambda_0;
        elseif lambda == 2
            y_exact = u_lambda_2;
        end
        SolutionPlot(lambda, n, y_exact, [0; u_SD; -2], 'SteepestDescent');
        SolutionPlot(lambda, n, y_exact, [0; u_CG; -2]', 'ConjugateGradient');
        
        if n == 400
            ConvPlot(lambda, iter_SD, conv_SD, iter_CG, conv_CG)
        end
    end
    TimePlot(lambda, nlist, SD_time, CG_time);
end