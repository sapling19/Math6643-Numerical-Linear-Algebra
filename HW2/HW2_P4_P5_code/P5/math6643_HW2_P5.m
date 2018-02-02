matDims = [100, 200, 300];
repeat = 3;
rng(20171001);
for n = matDims
    Rcjj_all = zeros(n,repeat);
    Rmjj_all = zeros(n,repeat);
    Rhjj_all = zeros(n,repeat);
    for k = 1:repeat
        [U, X] = qr(randn(n));
        [V, X] = qr(randn(n));
        S = diag(3.^(-1:-1:-n));
        A = U*S*V;
        
        [Qc, Rc] = ClassicalGS(A);
        Rcjj_all(:,k) = diag(Rc);
        
        [Qm, Rm] = ModifiedGS(A);
        Rmjj_all(:,k) = diag(Rm);
        
        [Qh, Rh] = Householder(A);
        Rhjj_all(:,k) = diag(Rh);
    end
    plot_p5(Rcjj_all, Rmjj_all)
end