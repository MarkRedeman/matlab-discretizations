%% forward_first_order:
function [A] = forward_first_order(x)
    import discretizations.n_from_x;
    [N, h] = n_from_x(x);
    A = spdiags(kron([1, -1], ones(N, 1)), [-1, 0], N, N) / h;
end
