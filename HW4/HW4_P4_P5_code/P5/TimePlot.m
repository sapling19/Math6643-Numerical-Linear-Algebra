function myplot = TimePlot(lambda, nlist, timelist1, timelist2)
    x = nlist;
    h = figure;
    loglog(x, timelist1, 'k-o', x, timelist2, 'k--*')
    xlabel('n', 'FontSize', 18)
    ylabel('Time (s)', 'FontSize', 18)
    xlim([80, 5000])
    legend('Steepest Descent', 'Conjugate Gradient', 'Location','northwest')
    set(gca, 'fontsize',14)
    saveas(h, sprintf('Time_lambda_%d.png', lambda))
    close(h)
end