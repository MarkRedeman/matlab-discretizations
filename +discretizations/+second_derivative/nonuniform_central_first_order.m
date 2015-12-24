%% nonuniform_first_order:
function [A] = nonuniform_central_first_order(x)
    % h = x(2 : end) - x(1 : end - 1);
    N = length(x);
    A = sparse(N, N);
    hm = x(2) - x(1);

    for j=2:length(x) - 1
        hp = x(j + 1) - x(j);
        h2 = hp + hm;
        A( j, j - 1) = 2 * 1 / (hm * h2);
        A(j, j) = - 2 * 1 / (hp * hm);
        A(j, 1 + j) = 2 * 1  / (hp * h2);
        hm = hp;
    end
end