function p = P4_Plot(u, nlist, J, GS, SOR1, SOR2, ylbl, yname)
    h = figure;
    if u == 5
        loglog(nlist, J, 'k--o', nlist, GS, 'k--*')
    else
        loglog(nlist, GS, 'k--*')
    end
    hold on
    loglog(nlist, SOR1, 'k--^', nlist, SOR2, 'k--d')
    hold off
    xlabel('n', 'FontSize', 18)
    ylabel(ylbl, 'FontSize', 18)
    xlim([90,1800])
    if u == 5
        legend('Jacobi', 'Gauss Seidel', 'SOR (w=1.60)', 'SOR (w=1.25)', 'Location', 'best')
    else
        legend('Gauss Seidel', 'SOR (w=1.60)', 'SOR (w=1.25)', 'Location', 'best')
    end
    legend('boxoff')
    set(gca, 'fontsize',14)
    saveas(h, sprintf('P4_u_%d_%s.png', u, yname))
    close(h)
end