function diff_eq = convert_to_differential(eq)

    eq_lhs = expand(lhs(eq));
    eq_rhs = expand(rhs(eq));
    
    % Substitutiing D with the differential operator
    if length(children(eq_lhs)) == 1
        terms_lhs = {eq_lhs};
    else
        terms_lhs = children(eq_lhs);
    end
    diff_eq_lhs = 0;
    for term = terms_lhs
        term_temp = term{1};
        diff_eq_lhs = diff_eq_lhs + substitute_differential(term_temp);
    end
    
    if length(children(eq_rhs)) == 1
        terms_rhs = {eq_rhs};
    else
        terms_rhs = children(eq_rhs);
    end

     diff_eq_rhs = 0;
     for term = terms_rhs
         term_tem = term{1};
         diff_eq_rhs = diff_eq_rhs + substitute_differential(term_tem);
     end
    diff_eq = diff_eq_lhs == diff_eq_rhs;
end



function result = substitute_differential(term)
    syms D  t em(t) ;
    if has(term, D)
        [coeff, powers] = coeffs(term, D);
        result = 0;
        for i = 1:length(powers)
            pow = powers(i);
            pow = extract_power(pow);
            coeff_term = coeff(i);
            if pow == 1
                result = result + diff(coeff_term , t);
            else
                result = result + diff(coeff_term, t, pow);
            end
        end
    elseif has(term, 1/D)
        [coeff, powers] = coeffs(term, 1/D);
        result = 0;
        for i = 1:length(powers)
            pow = powers(i);
            coeff_term = coeff(i);
            if pow == -1
                result = result + int(coeff_term * em(t), t);
            else
                result = result + int(coeff_term * em(t), t, -pow);
            end
        end
    else
        result = term;
    end
end



