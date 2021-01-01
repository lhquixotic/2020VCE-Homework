global gridN
global Ap
global Bp 
global Qp
global Rp


% Minimize the cost function
N = gridN;
H = diag([2*Qp*ones(1,N+1),2*Rp*ones(1,N)]);
H(1,1) = Qp;
H(N+1,N+1) = Qp;
H(N+2,N+2) = Rp;
H(2*N+1,2*N+1) = Rp;
cost_function = @(x) 0.5*x'*H*x;

% The initial parameter guess; 1 second, gridN positions, gridN velocities,
% gridN accelerations
x0 = [10; linspace(0,5,gridN)'; linspace(0,1,gridN)'];
% No linear inequality or equality constraints
A = [];
b = [];
Aeq = [];
Beq = [];
% Lower and Up bound
lb = [0;    ones(gridN * 2, 1) * -Inf];
ub = [Inf;  ones(gridN * 2, 1) * Inf];
% Options for fmincon
options = optimoptions(@fmincon, 'TolFun', 0.00000001, 'MaxIter', 10000, ...
                       'MaxFunEvals', 100000, 'Display', 'iter', ...
                       'DiffMinChange', 0.001, 'Algorithm', 'sqp');
% Solve for the best simulation time + control input
optimal = fmincon(cost_function, x0, A, b, Aeq, Beq, lb, ub, ...
              @control_plant_constraints, options);
% Plot the results
sim_time = 0:5/N:5;
state_x = optimal(1:N+1);
input_u = optimal(N+2:end);

figure(1)
plot(sim_time,state_x,'LineWidth',1.2)
xlabel("Time/s")
ylabel("State value")
grid on

figure(2)
plot(sim_time(1:N),input_u,'LineWidth',1.2)
xlabel("Time/s")
ylabel("Input value")
grid on