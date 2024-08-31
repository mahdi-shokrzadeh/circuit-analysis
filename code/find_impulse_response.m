function h_t = find_impulse_response(diff_eq , n , m)
    syms em(t) is_(t) v_s(t) y(t)

    diff_eq = subs(diff_eq, em(t), y(t));


    right_hand_eq = rhs(diff_eq);
    right_hand_eq = subs(right_hand_eq, is_(t), dirac(t));
    right_hand_eq = subs(right_hand_eq, v_s(t), dirac(t));

    final_eq = lhs(diff_eq) == right_hand_eq;
    disp("Final impulse equation:");
    disp(final_eq);
    lastwarn('');
    
    % h_t = dsolve(final_eq, y(0) == 0, diff(y(0), t) == 0);
    h_t = dsolve(final_eq);
    [warnMsg, warnId] = lastwarn;
     if ~isempty(warnMsg)
        warning('Could not solve the equation!');
        return;
    end
    z = 0;
    for k = n:m
        z = z+1;
        h_t = h_t + sym(sprintf('k%3(t)', k)) * dirac(t, z-1);
    end
    
    free_vars = symvar(h_t);
    free_vars = setdiff(free_vars, t); % Exclude the time variable t
    if ~isempty(free_vars)
        for i = 1:length(free_vars)
            h_t = subs(h_t, free_vars(i), 1);
        end
    end
    
    disp("Final answer:");
    disp(h_t);
    
    h_t_func = matlabFunction(h_t, 'Vars', t);
    
    fplot(h_t_func, [0, 30]); 
    title('Impulse Response');
    xlabel('Time (t)');
    ylabel('h(t)');
    ylim([0, 1.1]);

end
