function x_next = euler_int(x, xdot, dt)
    % forward Euler integration
    x_next = x + xdot*dt;