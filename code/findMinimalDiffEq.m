num = [3,2 , 4]; 
den = [5, 2 ,2,1 ,1 ];
sys = tf(num, den);

[sys_reduced, ~] = balred(sys, 3); 

t = linspace(0, 10, 1000);

u = ones(size(t));
y_original = lsim(sys, u, t);

y_reduced = lsim(sys_reduced, u, t);

figure;
plot(t, y_original, 'b', 'DisplayName', 'Original System');
hold on;
plot(t, y_reduced, 'r--', 'DisplayName', 'Reduced System');
xlabel('Time (s)');
ylabel('Response');
title('System Response Comparison');
legend;
grid on;

[num_reduced, den_reduced] = tfdata(sys_reduced, 'v');

% disp('Reduced Transfer Function:');
% disp(sys_reduced);
syms y(t) u(t)
ode = poly2sym (den_reduced , t ) * diff (y(t) , t ,length (den_reduced)-1) == ...
poly2sym ( num_reduced , t ) * diff ( u(t) , t ,length (num_reduced)-1);
disp ("Minimal Differential Equation :") ;
disp (ode) ;