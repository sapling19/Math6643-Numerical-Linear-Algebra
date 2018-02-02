for lambda = [0, 2]
    nlist = [256, 512, 1024, 2048];
    time_QR = []; norm_QR = [];
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
        tic;
        [eigVec, eigVal] = QR_eigen(A, 1e-8);
        t = toc;
        time_QR = [time_QR, t];
        norm_QR = [norm_QR, norm(A * eigVec - eigVec * eigVal)];
    end
    plot_P5(lambda, nlist, time_QR, 'Time (s)', 'QR');
end