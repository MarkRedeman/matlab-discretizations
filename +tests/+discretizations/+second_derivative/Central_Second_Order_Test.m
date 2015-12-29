classdef Central_Second_Order_Test < matlab.unittest.TestCase

    properties (TestParameter)
        N = {4, 8, 16, 32, 64, 128, 256, 512, 1024};
        % N = {4, 8, 16};
    end

    methods(Test, TestTags={'Small'})
        %% test_it_reverts_to_central_for_lambda_zero:
        function test_it_returns_an_n_times_n_matrix_in_sparse_format(t, N)
            import discretizations.second_derivative.central_second_order;

            x = linspace(0, 1, N);
            A = central_second_order(x);
            t.assertSize(A, [N, N]);
            t.assertTrue(issparse(A));
        end

        %% test_multiplying_with_a_constant_vector_results_in_zeros:
        function test_multiplying_with_a_constant_vector_results_in_zeros(t, N)
            import discretizations.second_derivative.central_second_order;

            x = linspace(0, 1, N);
            A = central_second_order(x);

            f = @(x) ones(length(x), 1);
            ddf = @(x) zeros(length(x), 1);
            b = A * f(x');

            t.assertEqual(b(2 : end - 1), ddf(x(2 : end - 1)'), 'AbsTol', 1E-10, ...
                'The second derivative of a constant function should be zero. Furthermore this should be exact.' ...
            );
        end

        %% test_multiplying_with_a_linear_vector_resluts_in_a_constant_vector:
        function test_multiplying_with_a_linear_vector_resluts_in_a_zero_vector(t, N)
            import discretizations.second_derivative.central_second_order;

            x = linspace(0, 1, N);
            A = central_second_order(x);

            f = @(x) x;
            b = A * f(x');
            ddf = @(x) zeros(length(x), 1);

            t.assertEqual(b(2 : end - 1), ddf(x(2 : end - 1)'), 'AbsTol', 1E-10, ...
                'The second derivative of a linear function should be zero. Furthermore this should be exact.' ...
            );
        end

        %% test_it_approximates_the_second_derivative_of_a_linear_function_by_machine_precission:
        function test_it_approximates_the_second_derivative_of_a_linear_function_by_machine_precission(t, N)
            import discretizations.second_derivative.central_second_order;

            x = linspace(0, 1, N);
            A = central_second_order(x);

            f = @(x) pi * x.^2;
            ddf = @(x) pi * 2 * ones(length(x), 1);
            b = A * f(x');

            t.assertEqual(b(2 : end - 1), ddf(x(2 : end - 1)), 'AbsTol', eps(N* 5E4) , ...
                'The second order central difference method should approximate the derivative of a linear function with machine precision.' ...
            );
        end

        %% test_central_is_forward_minus_backward:
        function test_h_times_central_is_forward_minus_backward_first_order_derivative(t, N)
            import discretizations.second_derivative.*;
            import discretizations.first_derivative.forward_first_order;
            import discretizations.first_derivative.backward_first_order;

            x = linspace(0, 1, N);
            h = x(2) - x(1);
            A = central_second_order(x);
            F = forward_first_order(x);
            B = backward_first_order(x);

            t.assertEqual(h * A, F - B, 'AbsTol', eps(10 * N), ...
                'The central finite difference method should equal forward minus backward finite difference' ...
            );
        end
    end

    methods (Test, TestTags={'Medium'})
        %% test_consistency_of_second_order_central:
        function test_consistency_of_second_order_central(t)

        end
    end
end