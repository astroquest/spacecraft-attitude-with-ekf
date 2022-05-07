function thetadot = kinematics(n, theta, omega)
    A = [ cos(theta(2)), sin(theta(1))*sin(theta(2)), cos(theta(1))*sin(theta(2)) ;
        0, cos(theta(1))*cos(theta(2)), -sin(theta(1))*cos(theta(2)) ;
        0, sin(theta(1)), cos(theta(1)) ];
    
    omega = [ omega(1), omega(2), omega(3) ]';
    
    c = [ sin(theta(3)), cos(theta(2))*cos(theta(3)), sin(theta(2))*sin(theta(3)) ]';
    
    
    thetadot(1:3) = 1/cos(theta(2))*A*omega + n/cos(theta(2))*c;