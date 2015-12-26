%% second_order_lambda:
function [A] = second_order_lambda(x, lambda)
    import discretizations.n_from_x;
    import discretizations.first_derivative.central_second_order;

    % Revert to quick scheme by default
    if (nargin < 2)
        lambda = 1 / 8;
    end

    [N, h] = n_from_x(x);
    A = central_second_order(x) - (lambda / h) * ...
        (spdiags(kron([- 1, 3, - 3, 1], ones(N, 1)), [-2 : 1], N, N));
end