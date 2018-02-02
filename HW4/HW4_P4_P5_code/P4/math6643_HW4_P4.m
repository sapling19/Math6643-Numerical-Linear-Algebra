rng(100); tol = 1e-14;
ulist = [5 -5];
nlist = [100 200 400 800 1600];
for u = ulist
    J_Time = []; GS_Time = []; SOR_Time1 = []; SOR_Time2 = [];
    J_Iter = []; GS_Iter = []; SOR_Iter1 = []; SOR_Iter2 = [];
    J_norm = []; GS_norm = []; SOR_norm1 = []; SOR_norm2 = [];
    for n = nlist
        r = [[10, 3, 2, 1], zeros(1,n-4)];
        T = toeplitz(r);
        A = T + u * eye(n);
        b = randn(n, 1);
        
        D = diag(diag(A));
        E = D - tril(A);
        F = D - triu(A);
        G_J = D \ (E + F);
        G_GS = (D - E) \ F;
        eigval_J = max(abs(eig(G_J)));
        eigval_GS = max(abs(eig(G_GS)));
        fprintf('Jacobi: p(G) = %f\n', eigval_J)
        fprintf('GS: p(G) = %f\n', eigval_GS)
        
        tic;
        [x, iters1, conv1] = jacobi(A, b, tol);
        t = toc;
        J_Time = [J_Time, t];
        J_Iter = [J_Iter, iters1];
        J_norm = [J_norm, norm(b - A * x)];
        fprintf('Jacobi: %f\n', norm(b - A * x))

        tic;
        [x, iters2, conv2] = GaussSeidel(A, b, tol);
        t = toc;
        GS_Time = [GS_Time, t];
        GS_Iter = [GS_Iter, iters2];
        GS_norm = [GS_norm, norm(b - A * x)];
        fprintf('GS: %f\n', norm(b - A * x))
        
        tic;
        [x, iters3, conv3] = SOR(A, b, 1.60, tol);
        t = toc;
        SOR_Time1 = [SOR_Time1, t];
        SOR_Iter1 = [SOR_Iter1, iters3];
        SOR_norm1 = [SOR_norm1, norm(b - A * x)];
        fprintf('SOR1: %f\n', norm(b - A * x))
        
        tic;
        [x, iters4, conv4] = SOR(A, b, 1.25, tol);
        t = toc;
        SOR_Time2 = [SOR_Time2, t];
        SOR_Iter2 = [SOR_Iter2, iters4];
        SOR_norm2 = [SOR_norm2, norm(b - A * x)];
        fprintf('SOR2: %f\n', norm(b - A * x))
        
        fprintf('\n')
        if n == 800
            P4_Plot_conv(u, iters1, conv1, iters2, conv2, iters3, conv3, iters4, conv4)
        end
    end
    slope = (log(SOR_Time2(5)) - log(SOR_Time2(3))) / (log(nlist(5)) - log(nlist(3)));
    fprintf('slope = %f\n', slope)
    
    P4_Plot(u, nlist, J_Time, GS_Time, SOR_Time1, SOR_Time2, 'Time (s)', 'time')
    P4_Plot(u, nlist, J_Iter, GS_Iter, SOR_Iter1, SOR_Iter2, 'Iterations', 'iter')
    P4_Plot(u, nlist, J_norm, GS_norm, SOR_norm1, SOR_norm2, '||b - Ax||_2', 'norm')
end