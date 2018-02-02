time_GR = []; repeat = 3;
nlist = [100, 200, 400, 800, 1600, 3200];
for n = nlist
    t = 0;
    for i=1:repeat
        A = diag(randn(1,n));
        A(2:n,1) = randn(n-1,1);
        A(1,2:n) = randn(1,n-1);
        tic;
        [Q, R] = QR_GivenRot(A);
        t_temp = toc;
        if norm(A-Q*R) > 1e-10
            disp('Warning: large norm')
        end
        t = t + t_temp;
    end
    time_GR = [time_GR, t/repeat];
end

h = figure;
loglog(nlist, time_GR, 'k-o')
xlabel('n', 'FontSize', 18)
ylabel('Time (s)', 'FontSize', 18)
legend('Givens Rotation', 'Location', 'northwest')
set(gca, 'fontsize',14)
saveas(h, sprintf('P41.png'))
close(h)
