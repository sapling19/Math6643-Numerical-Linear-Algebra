function myplot = SolutionPlot(lambda, n, y_exact, u_list, key)

x = linspace(0, 1, n+2);
h = figure;
plot(x, u_list, 'ro')
hold on
fplot(y_exact, [0, 1], 'k-')
hold off
xlabel('x', 'FontSize', 18)
ylabel('u(x)', 'FontSize', 18)
legend(key, 'Exact Solution')
set(gca, 'fontsize',14)
str = sprintf('lambda=%d, n=%d', lambda, n);
text(0.1, -1.8, str,'FontSize', 18)
saveas(h, sprintf('lambda_%d_n_%d_%s.png', lambda, n, key))
close(h)