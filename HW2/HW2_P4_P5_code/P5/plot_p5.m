function f = plot_p5(Rc, Rm)

[n, repeat] = size(Rc);
x = 1:n;
for j = 1:repeat
    h = figure;
    semilogy(x, Rc(:,j), 'ko')
    hold on
    semilogy(x, Rm(:,j), 'k*')
    semilogy(x, linspace(10^(-16),10^(-16),n), 'k-.')
    semilogy(x, linspace(10^(-8),10^(-8),n), 'k-.')
    semilogy((1:50), (3.^(-1:-1:-50)), 'k--')
    hold off
    xlabel('j', 'FontSize', 18)
    ylabel('R_{jj}', 'FontSize', 18)
    legend('Classical GS', 'Modified GS')
    set(gca, 'fontsize',14)
    %str = sprintf('3^{-j}');
    text(n-n/10, 10^(-9), '10^{-8}','FontSize', 10)
    text(n-n/10, 10^(-15), '10^{-16}','FontSize', 10)
    saveas(h, sprintf('n_%d_repeat_%d.png', n, j))
    close(h)
end