for lambda = [0, 2]
    nlist = [256, 512, 1024, 2048, 4096];
    time_sml = []; time_lag = [];
    error_sml = []; error_lag = [];
    eigval_sml = []; eigval_lag = [];
    condA = [];
    for n = nlist
        disp(n)
        n = n - 2;
        h = 1/(n+1);
        A = zeros(n+2); A(1, 1) = 1; A(n+2, n+2) = 1;
        for k = 2:1:n+1
            A(k, k-1) = 1;
            A(k, k) = -(2 + lambda * h^2);
            A(k, k+1) = 1;
        end
        condA = [condA, cond(A)];
        [V, D] = eig(A); abs_eigvals = abs(diag(D));
        small_val = min(abs_eigvals)
        large_val = max(abs_eigvals)
        
        tic;
        invA = inv(A);
        [eigvalSml, eigvecSml, iterCountSml] = PowerIteration(invA, 1e-8);
        t1 = toc;
        eigvalSml = 1/abs(eigvalSml);
        eigval_sml = [eigval_sml, eigvalSml];
        time_sml = [time_sml, t1];
        error_sml = [error_sml, (eigvalSml-small_val)/small_val];
        
        tic
        [eigvalLag, eigvecLag, iterCountLag] = PowerIteration(A, 1e-8);
        t2 = toc;
        eigval_lag = [eigval_lag, eigvalLag];
        time_lag = [time_lag, t2];
        error_lag = [error_lag, (abs(eigvalLag)-large_val)/large_val];
    end
    plot_P5(lambda, nlist, condA, 'Condition Number', 'condA')
    plot_P5(lambda, nlist, time_sml, 'Time (s)', 'sml')
    plot_P5(lambda, nlist, time_lag, 'Time (s)', 'lag')
end