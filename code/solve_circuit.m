function eq = solve_circuit(A, W, m)
    [n, ~] = size(A);
    
    if length(W) ~= n || m > n
        error('Dimensions of A and W must match, and m must be within bounds.');
    end
 
    syms t D is_(t)
    A_det = det(A); 
    A_mod = A;
    A_mod(:, m) = W;
    A_mod_det = det(A_mod);
    
    syms em(t);  
    equation = A_det * em(t) == A_mod_det;
    equation = expand(equation);
    
    eq = collect(equation, em(t));
    %disp("base eq");
    %disp(eq);
    eq_lhs = lhs(eq);
    eq_rhs = rhs(eq);

    [num_lhs, den_lhs] = numden(eq_lhs); 
    [num_rhs, den_rhs] = numden(eq_rhs); 
    min_power_lhs = min(feval(symengine, 'degree', den_lhs, D));
    min_power_rhs = min(feval(symengine, 'degree', den_rhs, D));
    max_power_lhs = min(feval(symengine, 'degree', den_lhs, D));
    max_power_rhs = min(feval(symengine, 'degree', den_rhs, D));
    min_power = max(min_power_lhs, min_power_rhs);
    if min_power > 0
        eq = eq * D^(min_power);
        eq = expand(eq); 
        eq = collect(eq, em(t));
    end
    eq = collect(eq,is_(t));
    disp("Collected D-form equation:");
    disp(eq);
    eq = expand(eq);
    eq=[eq ,max_power_lhs , max_power_rhs ];
end
