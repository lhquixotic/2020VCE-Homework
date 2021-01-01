function [ c, ceq ] = control_plant_constraints( x )
    global gridN
    global Ap
    global Bp 
    % No nonlinear inequality constraint needed
    c = [];
    % Calculate the timestep
    sim_time = 5;
    delta_time = sim_time / gridN;
    
    % Get the states / inputs out of the vector
    state_x = x(1          :   1 + gridN);
    input_u = x(2 + gridN  :   1 + gridN*2);
    
    % Constrain initial position and velocity to be zero
    ceq = [state_x(1)-10; state_x(end)];
    for i = 1 : length(state_x) - 1
        xdot_i = Ap*state_x(i)+Bp*input_u(i);
        xx = (state_x(i+1) - state_x(i))/delta_time;
        ceq = [ceq ; xx - xdot_i];
    end
    % Constrain end position to 1 and end velocity to 0
    ceq = [ceq];
end