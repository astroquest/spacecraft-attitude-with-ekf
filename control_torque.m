function Tc = control_torque(Kp, Kd, theta, thetadot)
    % control torque with PD control
    Tc(1) = -Kp(1)*theta(1) - Kd(1)*thetadot(1);
    Tc(2) = -Kp(2)*theta(2) - Kd(2)*thetadot(2);
    Tc(3) = -Kp(3)*theta(3) - Kd(3)*thetadot(3);
    
    