hhTime = []; hhmTime = []; Rnorm = [];
nlist = 100:100:2000;
for n = nlist
    r = [[10, 3, 2, 1], zeros(1,n-4)];
    A = toeplitz(r);
    
    tic;
    [Qh, Rh] = Householder(A);
    t1 = toc;
    hhTime = [hhTime, t1];
    
    tic;
    [Qhm, Rhm] = Householder_modified(A, 3);
    t2 = toc;
    hhmTime = [hhmTime, t2];
    
    Rnorm = [Rnorm, norm(Rhm - Rh, 2)];
end

%fileID = fopen('p4.txt','w');
%fprintf(fileID, '%e,%e,%e\n', [hhTime; hhmTime; Rnorm]);
%fclose(fileID);

h = figure;
loglog(nlist, hhTime, 'k-o')
hold on
loglog(nlist, hhmTime, 'k--*')
hold off
xlabel('n', 'FontSize', 18)
ylabel('Time (s)', 'FontSize', 18)
xlim([100,2100])
legend('Householder', 'Modified Householder','Location', 'northwest')
set(gca, 'fontsize',14)
saveas(h, sprintf('P4.png'))
close(h)