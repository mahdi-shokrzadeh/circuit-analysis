function power = extract_power(expr)
    expr_str = char(expr);
  
    if strcmp(expr_str, 'D')
        power = 1;
    else
        power_str = expr_str(end);
        power = str2double(power_str);
    end
end
