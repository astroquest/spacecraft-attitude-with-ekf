function omegadot = dynamics(J, Td, Tc, n, theta, omega)
    M = [0, -cos(theta(1))*cos(theta(2)), sin(theta(1))*cos(theta(2)) ;
        cos(theta(1))*cos(theta(2)), 0, sin(theta(2)) ;
        -sin(theta(1))*cos(theta(2)), -sin(theta(2)), 0 ];

    s = [ -sin(theta(2)), sin(theta(1))*cos(theta(2)), cos(theta(1))*cos(theta(2)) ]';

    Omega       = [0 -omega(3) omega(2) ;
                   omega(3) 0 -omega(1) ;
                   -omega(2) omega(1) 0 ];
    omega       = [ omega(1), omega(2), omega(3) ]';
    omegadot    = J\(-Omega*J*omega + 3*n^2*M*J*s + Tc + Td);