syms D is_(t) v_s(t)
% entry one
% m = 1;
% W =[is_(t)];
% A = [D+3];


% entry two
% m=1;
% A = [D^-1 + 2 + D*(1/2)];
% W=[is_(t)];


% entry three
% m = 1;
% A = [D+1,-1,0;
%     -1 , 2+4*D^(-1) , -4*D^(-1);
%     0,-4*D^(-1), 1+4*D^(-1)];
% W = [is_(t),0,0];


% RLC , C=1 , L=1/4 , R=1/2
% entry four
m = 1;
A = [D^(-1)* 4 + 2 + D];
W = [is_(t)];

 
% m = 1;
% A = [D+2,-1,0,0;
%     -1 , 2+5*D^(-1) , -5*D^(-1), 0;
%     0,-5*D^(-1), 1+5*D^(-1), -1;
%     0, 0, -1, D+6];
% W = [is_(t),0,0,0];


% m = 1;
% A = [D + 2, -1, D^2, D^3, D^(-1), D^(-2), D^(-3), D^(-4);
%     -1, 2 + 5*D^(-1), -5*D^(-1), D^(-1), D^2, D^(-1), D^(-2), D^(-3);
%     D^(-2), -5*D^(-1), 1 + 5*D^(-1), -1, D^(-3), D^(-2), D^(-1), D^(-2);
%     D^(-3), D^(-1), -1, D + 6, D^(-4), D^(-3), D^(-2), D^(-1);
%     D^(-1), D^2, D^(-3), D^(-4), D, D^(-1), D^(-2), D^(-3);
%     D^(-2), D^(-1), D^(-2), D^(-3), D^(-1), D, D^(-1), D^(-2);
%     D^(-3), D^(-2), D^(-1), D^(-2), D^(-2), D^(-1), D, D^(-1);
%     D^(-4), D^(-3), D^(-2), D^(-1), D^(-3), D^(-2), D^(-1), D];
% W = [is_(t), 0, 0, 0, 0, 0, 0, 0];

% m =1;
% A = [1+0.5*D^2,-0.5*D^2;
%      -0.5*D^2, 1+0.5*D^2];
% W = [0;is_(t)];


% Solve for e_m(t)
eq = solve_circuit(A, W, m);
disp('Differential Equation:');
disp(eq(1));

% Convert the D-operator form to a differential equation
diff_eq = convert_to_differential(eq(1));
disp('Converted Differential Equation:');
disp(diff_eq);

% Find the impulse response
h_t = find_impulse_response(diff_eq, eq(2) , eq(3));
disp('Impulse Response:');
disp(h_t);

% Find the frequency response
H_s = find_frequency_response(eq(1));
disp('Frequency Response:');
disp(H_s);

