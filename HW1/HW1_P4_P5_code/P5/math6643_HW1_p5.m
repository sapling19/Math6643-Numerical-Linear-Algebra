u_lambda_0 = @(x)(-0.5 * x^3 + 0.25 * x^2 - 1.75 * x);
u_lambda_2 = @(x)(((exp(sqrt(2)) + 13)*exp(-sqrt(2) * x) - (exp(-sqrt(2)) + 13)*exp(sqrt(2) * x))/(4*(exp(sqrt(2)) - exp(-sqrt(2)))) + 1.5*x - 0.25);
%u_lambda_2 = @(x)(3*x)/2 - (exp(2^(1/2)*x)*(13*exp(2^(1/2)) + 1))/(4*(exp(2*2^(1/2)) - 1)) + (exp(-2^(1/2)*x)*exp(2^(1/2))*(exp(2^(1/2)) + 13))/(4*(exp(2*2^(1/2)) - 1)) - 1/4;

for lambda = [0, 2]
    GaussNaive_time = [];
    GaussPP_time = [];
    nlist = [200, 400, 800, 1000, 2000, 4000];
    
    for n = nlist
        h = 1/(n+1);
        A = zeros(n+2); b = zeros(n+2, 1);
        A(1, 1) = 1; A(n+2, n+2) = 1;
        b(n+2) = -2;
        for k = 2:1:n+1
            A(k, k-1) = 1;
            A(k, k) = -(2 + lambda * h^2);
            A(k, k+1) = 1;
            b(k) = 0.5 * h^2 - 3 * (k-1) * h^3;
        end
        
        tic;
        u_list1 = GaussNaive(A,b);
        t1 = toc;
        GaussNaive_time = [GaussNaive_time, t1];
        
        tic
        u_list2 = GaussPP(A,b);
        t2 = toc;
        GaussPP_time = [GaussPP_time, t2];
        
        if lambda == 0
            y_exact = u_lambda_0;
        elseif lambda == 2
            y_exact = u_lambda_2;
        end
        SolutionPlot(lambda, n, y_exact, u_list1, 'GaussNaive');
        SolutionPlot(lambda, n, y_exact, u_list2, 'GaussPP');
    end
    TimePlot(lambda, nlist, GaussNaive_time, GaussPP_time);
end