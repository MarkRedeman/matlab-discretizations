%% nonuniform_first_order:
function [A] = nonuniform_central_first_order(x)
    N = length(x);
    A = sparse(N, N);
    hm = x(2) - x(1);

    parfor j = 2 : N - 1
        hp = x(j + 1) - x(j);
        h2 = hp + hm;
        A(j, j - 1) = 1 / h2;
        A(j, 1 + j) = - 1 / h2;
        hm = hp;
    end
end