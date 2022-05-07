mu  =   398600.4418;                % grav parameter Earth
R   =   (700 + 6371);               % orbit radius
n   =   sqrt(mu/R^3);               % mean motion
J   =   [   2700 0 0 ;
            0 2300 0 ;
            0 0 3000 ];             % diagonal of inertia tensor
Td  =   [ 0.001, 0.001, 0.001 ]';    % constant disturbance torques