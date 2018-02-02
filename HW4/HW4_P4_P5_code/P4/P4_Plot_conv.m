function p = P4_Plot_conv(u, iters1, conv1, iters2, conv2, iters3, conv3, iters4, conv4)
    h = figure;
    if u == 5
        step = 3;
        semilogy(1:step:iters1, conv1(1:step:end), 'k--o', 1:step:iters2, conv2(1:step:end), 'k--*')
    else
        step = 6;
        semilogy(1:step:iters2, conv2(1:step:end), 'k--*')
    end
    hold on
    semilogy(1:step:iters3, conv3(1:step:end), 'k--^', 1:step:iters4, conv4(1:step:end), 'k--d')
    hold off
    xlabel('steps', 'FontSize', 18)
    ylabel('||x^k - x^{k-1}||_2', 'FontSize', 18)
    if u == 5
        legend('Jacobi', 'Gauss Seidel', 'SOR (w=1.60)', 'SOR (w=1.25)', 'Location', 'northeast')
    else
        legend('Gauss Seidel', 'SOR (w=1.60)', 'SOR (w=1.25)', 'Location', 'northeast')
    end
    legend('boxoff')
    set(gca, 'fontsize',14)
    saveas(h, sprintf('P4_u_%d_conv.png', u))
    close(h)
end