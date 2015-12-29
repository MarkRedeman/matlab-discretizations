classdef Nonuniform_Central_First_Order_Test < matlab.unittest.TestCase

    properties (TestParameter)
        N = {4, 8, 16, 32, 64, 128, 256, 512, 1024};
    end

    methods(Test, TestTags={'Small'})
        %% test_nonuniform_equals_central_for_uniform_grid:
        function test_nonuniform_equals_central_for_uniform_grid(t, N)
            import discretizations.second_derivative.nonuniform_central_first_order;
            import discretizations.second_derivative.central_second_order;

            x = linspace(0, 1, N);
            A = nonuniform_central_first_order(x);
            C = central_second_order(x);

            t.assertEqual(A(2 : end - 1, 2 : end - 1), C(2 : end - 1, 2 : end -1), 'AbsTol', eps(N) * 5E6);
        end
    end

    methods (Test, TestTags={'Medium'})
        %% test_consistency_of_second_order_central:
        function test_consistency_of_second_order_central(t)

        end
    end
end