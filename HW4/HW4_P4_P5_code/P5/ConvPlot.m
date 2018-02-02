function p = ConvPlot(lambda, iters1, conv1, iters2, conv2)
    h = figure;
    step1 = floor(iters1 / 50); step2 = floor(iters2 / 50);
    loglog(1:step1:iters1, conv1(1:step1:end), 'k--o', 1:step2:iters2, conv2(1:step2:end), 'k--*')
    xlabel('steps', 'FontSize', 18)
    ylabel('||x^k - x^{k-1}||_2', 'FontSize', 18)
    legend('Steepest Descent', 'Conjugate Gradient', 'Location', 'northeast')
    legend('boxoff')
    set(gca, 'fontsize',14)
    saveas(h, sprintf('P5_lambda_%d_conv.png', lambda))
    close(h)
end