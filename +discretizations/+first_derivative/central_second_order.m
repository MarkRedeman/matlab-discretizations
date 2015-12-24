%% central_first_order:
function [A] = central_second_order(x)
    import discretizations.first_derivative.second_order_lambda;
    A = second_order_lambda(x, 0);

    % We can also compute the matrix directly
    % [N, h] = n_from_x(x);
    % A = spdiags(kron([1, -1], ones(N, 1)), [-1, 1], N, N) / (2 * h);
end