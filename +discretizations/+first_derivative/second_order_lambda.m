%% central_first_order:
function [A] = second_order_lambda(x, lambda)
    import discretizations.n_from_x;
    % Revert to quick scheme by default
    if (nargin < 2)
        lambda = 1 / 8;
    end

    [N, h] = n_from_x(x);
    A = spdiags(kron([-1, 1], ones(N, 1)), [-1, 1], N, N) / (2 * h) - ...
        lambda * (spdiags(kron([- 1, 3, - 3, 1], ones(N, 1)), [-2 : 1], N, N)) / h;
end