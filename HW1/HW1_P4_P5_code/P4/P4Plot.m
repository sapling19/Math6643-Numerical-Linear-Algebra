function plt = P4Plot(x, y, ylabels, fignames)

for i = 1:length(y)
    h = figure;
    plot(x, y{i}, 'k-o')
    xlabel('m', 'FontSize', 18)
    ylabel(ylabels{i}, 'FontSize', 18)
    set(gca, 'fontsize',14)
    %str=sprintf('ode45: AbsTol=%.1d',1e-6);
    %text(20, 0.005, str,'FontSize', 18)
    saveas(h, sprintf(strcat(fignames{i}, '.png')))
    close(h)
end