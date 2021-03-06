classdef Backward_First_Order_Test < matlab.unittest.TestCase

    properties (TestParameter)
        N = {4, 8, 16, 32, 64, 128, 256, 512, 1024};
        % N = {64, 128};
    end

    methods(Test, TestTags={'Small'})
        %% test_it_reverts_to_central_for_lambda_zero:
        function test_it_returns_an_n_times_n_matrix_in_sparse_format(t, N)
            import discretizations.first_derivative.backward_first_order;

            x = linspace(0, 1, N);
            A = backward_first_order(x);
            t.assertSize(A, [N, N]);
            t.assertTrue(issparse(A));
        end

        %% test_multiplying_with_a_constant_vector_results_in_zeros:
        function test_multiplying_with_a_constant_vector_results_in_zeros(t, N)
            import discretizations.first_derivative.backward_first_order;

            x = linspace(0, 1, N);
            A = backward_first_order(x);

            f = @(x) ones(length(x), 1);
            df = @(x) zeros(length(x), 1);
            b = A * f(x');

            t.assertEqual(b(2 : end - 1), df(x(2 : end - 1)'), 'AbsTol', 1E-12, ...
                'The derivative of a constant function should be zero. Furthermore this should be exact.' ...
            );
        end

        %% test_multiplying_with_a_linear_vector_resluts_in_a_constant_vector:
        function test_multiplying_with_a_linear_vector_resluts_in_a_constant_vector(t, N)
            import discretizations.first_derivative.backward_first_order;

            x = linspace(0, 1, N);
            A = backward_first_order(x);

            f = @(x) x;
            b = A * f(x');

            t.assertFalse(any(b(2) ~= b(2 : end - 1)), ...
                'The derivative of a linear function should be a constant' ...
            );
        end

        %% test_it_approximates_the_first_derivative_of_a_linear_function_by_machine_precission:
        function test_it_approximates_the_first_derivative_of_a_linear_function_by_machine_precission(t, N)
            import discretizations.first_derivative.backward_first_order;

            x = linspace(0, 1, N);
            A = backward_first_order(x);

            f = @(x) pi * x;
            df = @(x) pi * ones(length(x), 1);
            b = A * f(x');

            t.assertEqual(b(2 : end - 1), df(x(2 : end - 1)), 'AbsTol', eps(10 * N), ...
                'The first order backward difference method should approximate the derivative of a linear function with machine precision.' ...
            );
        end

        %% test_it_is_accurate_up_to_first_order:
        function test_the_discetization_error_is_dominated_by_the_second_derivative(t, N)
            import discretizations.first_derivative.backward_first_order;

            x = linspace(0, 1, N);
            h = x(2) - x(1);
            A = backward_first_order(x);

            f = @(x) pi * x.^2;
            df = @(x) pi * 2 * x;
            ddf = @(x) pi * 2 * ones(length(x), 1);
            b = A * f(x');

            actual_error = b(2 : end - 1) - df(x(2 : end - 1)');
            expected_error = - ddf(x(2 : end - 1)') * (h) / 2;

            t.assertEqual(actual_error, expected_error, 'AbsTol', eps(10 * N), ...
                'The truncation error is dominated by the second derivative.' ...
            );
        end
    end

    methods (Test, TestTags={'Medium'})
        %% test_consistency_of_second_order_central:
        function test_consistency_of_second_order_central(t)

        end
    end
end