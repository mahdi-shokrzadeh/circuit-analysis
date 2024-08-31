function H_jw = find_frequency_response(eq)
    syms em(t) is_(t) v_s(t) D w ;
    eq_lhs = expand(lhs(eq));
    eq_rhs = expand(rhs(eq));
    num =  return_need(eq_rhs);
    dinom = return_need(eq_lhs);
    
    H_jw = num/dinom;
    H_jw = simplify(H_jw);
    disp("H_jw:");
    disp(H_jw);
    if has(H_jw, t)
        H_jw = subs(H_jw, t, 2*pi/w);
    end
    H_jw_func = matlabFunction(H_jw, 'Vars', w);

    % where till where?
    freq_range = -10:0.1:10;  
    H_jw_vals = arrayfun(H_jw_func, freq_range);
    
    % Amplitude res
    figure;
    subplot(2, 1, 1);
    plot(freq_range, abs(H_jw_vals));
    title('Magnitude Response');
    xlabel('Frequency (rad/s)');
    ylabel('|H(j\omega)|');
    
    % Phase res
    subplot(2, 1, 2);
    plot(freq_range, unwrap(angle(H_jw_vals)));
    title('Phase Response');
    xlabel('Frequency (rad/s)');
    ylabel('<H(j\omega) (radians)');
end


function R_t = return_need(eq)
    result = 0;
    syms s t em(t) is_(t) v_s(t) w D tem_i
    temp_i = sqrt(-1);
    eq = subs(eq , em(t) , 1);
    eq = subs(eq , v_s(t) , 1);
    eq = subs(eq , is_(t) , 1);

    num = 0;
    terms_lhs = children(eq);
    diff_eq_lhs = 0;
    for term = terms_lhs
        term = term{1};
        if has(term, D)
            [coeff, powers] = coeffs(term, D);
            for i = 1:length(powers)
                pow = powers(i);
                pow = extract_power(pow);
                coeff_term = coeff(i);
                if pow == 1
                    result = result + coeff_term * (w*temp_i);
                else
                    result = result + coeff_term * (w*temp_i)^pow;
                end
            end
        else
           result = result + term; 
        end
    end
    R_t = result;
end

