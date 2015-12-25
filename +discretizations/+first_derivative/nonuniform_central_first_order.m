%% nonuniform_first_order:
function [A] = nonuniform_central_first_order(x)
    N = length(x);

    h = 1 ./ [1, x(3 : end) - x(1 : end - 2), 1];
    A = spdiags([ - [h(2 : end), 1]', [1, h(1 : end - 1)]'], [- 1, 1], N, N);
end
