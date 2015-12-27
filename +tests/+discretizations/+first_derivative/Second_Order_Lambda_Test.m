classdef Second_Order_Lambda_Test < matlab.unittest.TestCase

    properties (TestParameter)
        N = {4, 8, 16, 32, 64, 128, 256, 512, 1024};
    end

    methods(Test, TestTags={'Small'})
        %% test_it_reverts_to_central_for_lambda_zero:
        function test_for_lambda_zero_it_equals_central_second_order(t, N)
            import discretizations.first_derivative.second_order_lambda;
            import discretizations.first_derivative.central_second_order;

            x = linspace(0, 1, N);
            A = second_order_lambda(x, 0);
            C = central_second_order(x);

            t.assertEqual(A(2 : end - 1, 2 : end - 1), C(2 : end - 1, 2 : end -1), 'AbsTol', eps(200 * N));
        end
    end

    methods (Test, TestTags={'Medium'})
        %% test_consistency_of_second_order_central:
        function test_consistency_of_second_order_central(t)

        end
    end
end