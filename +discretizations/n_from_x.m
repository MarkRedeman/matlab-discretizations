%% n_from_x:
function [N, h] = n_from_x(x)
    N = length(x);
    h = x(2) - x(1);
end
