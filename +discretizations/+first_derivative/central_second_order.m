%% central_first_order:
function [A] = central_second_order(x)
    import discretizations.n_from_x;

    [N, h] = n_from_x(x);
    A = spdiags(kron([-1, 1], ones(N, 1)), [-1, 1], N, N) / (2 * h);
end