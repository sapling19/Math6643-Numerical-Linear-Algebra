function plot_P5(lambda, nlist, yvals, ystr, fstr)
    h = figure;
    loglog(nlist, yvals, 'k-o')
    xlabel('n', 'FontSize', 18)
    ylabel(ystr, 'FontSize', 18)
    %legend(lstr, 'Location', 'northwest')
    set(gca, 'fontsize',14)
    saveas(h, sprintf('lambda_%d_%s.png', lambda, fstr))
    close(h)
end
