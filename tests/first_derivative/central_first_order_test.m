%% test_discretize_b3:
function [tests] = test_discretize_first_derivative_first_order(t)
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    % p = addpath('./../../');
    % t.addTeardown(@path, p);
end

%% test_it_reverts_to_central_for_lambda_zero:
function test_it_returns_an_n_times_n_matrix_in_sparse_format(t)
    import discretizations.first_derivative.central_second_order;
    N = 8;
    x = linspace(0, 1, N);
    A = central_second_order(x);
    t.assertSize(A, [N, N]);
    t.assertTrue(issparse(A));
end

%% test_multiplying_with_a_constant_vector_results_in_zeros:
function test_multiplying_with_a_constant_vector_results_in_zeros(t)
    import discretizations.first_derivative.central_second_order;

    N = 5;
    x = linspace(0, 1, N);
    A = central_second_order(x);

    f = @(x) zeros(length(x), 1);
    b = A * f(x');

    t.assertEqual(b(2 : end - 1), zeros(N - 2, 1), 'AbsTol', 1E-12, ...
        'The derivative of a constant function should be zero. Furthermore this should be exact.' ...
    );
end

%% test_multiplying_with_a_linear_vector_resluts_in_a_constant_vector:
function test_multiplying_with_a_linear_vector_resluts_in_a_constant_vector(t)
    import discretizations.first_derivative.central_second_order;

    N = 5;
    x = linspace(0, 1, N);
    A = central_second_order(x);

    f = @(x) x;
    b = A * f(x');
    t.assertFalse(any(b(2) ~= b(2 : end - 1)), ...
        'The derivative of a linear function should be a constant' ...
    );
end

%% test_it_approximates_the_first_derivative_of_a_linear_function_by_machine_precission:
function test_it_approximates_the_first_derivative_of_a_linear_function_by_machine_precission(t)
    import discretizations.first_derivative.central_second_order;

    N = 5;
    x = linspace(0, 1, N);
    A = central_second_order(x);

    f = @(x) pi * x;
    df = @(x) pi * ones(length(x), 1);
    b = A * f(x');

    t.assertEqual(b(2 : end - 1), df(x(2 : end - 1)), 'AbsTol', 1E-12, ...
        'The first order central difference method should approximate the derivative of a linear function with machine precision.' ...
    );
end

%% test_it_is_accurate_up_to_first_order:
function test_the_discetization_error_is_dominated_by_the_second_derivative(t)
    import discretizations.first_derivative.central_second_order;

    N = 128;
    x = linspace(0, 1, N);
    h = x(2) - x(1);
    A = central_second_order(x);

    f = @(x) pi * x.^3;
    df = @(x) pi * 3 * x.^2;
    dddf = @(x) pi * 3 * 2 * ones(length(x), 1);
    b = A * f(x');

    actual_error = b(2 : end - 1) - df(x(2 : end - 1)');
    expected_error = dddf(x(2 : end - 1)') * (h^2) / 6;

    t.assertEqual(actual_error, expected_error, 'AbsTol', 1E-12, ...
        'The truncation error is dominated by the third derivative.' ...
    );
end