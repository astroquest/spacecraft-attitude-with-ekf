function xdot = kinematics2(n, x, omega)
    % additional kinematics function for use inside ekf.m 
    A = [ cos(x(2)), sin(x(1))*sin(x(2)), cos(x(1))*sin(x(2)) ;
        0, cos(x(1))*cos(x(2)), -sin(x(1))*cos(x(2)) ;
        0, sin(x(1)), cos(x(1)) ];
    
    omega = [ omega(1) - x(4), omega(2) - x(5), omega(3) - x(6) ]';
    
    c = [ sin(x(3)), cos(x(2))*cos(x(3)), sin(x(2))*sin(x(3)) ]';
    
    
    xdot(1:3) = (1/cos(x(2)))*A*omega + (n/cos(x(2)))*c;
    xdot(4:6) = [ 0; 0; 0];