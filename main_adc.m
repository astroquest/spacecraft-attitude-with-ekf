clear all
close all
%% DATA
parameters

%% GAIN
pd_gains

%% SIM SETTINGS
simTime     =   500;                   % in seconds
dt          =   1;                      % time stepsize in seconds
N           =   simTime/dt;             % nr. of simulation steps

% addition of bias and noise in measurements (1=enable, 0=disable)
bias_noise  =   0;  
% addition of EKF for state estimation (1=enable, 0=disable)
filter      =   0;             

%% STOCHASTIC VECTORS & MATRICES
stdv        =   deg2rad(0.1);                       % white noise std
v           =   stdv*randn(3,N);                    % noise vector
R           =   diag([stdv^2, stdv^2, stdv^2]);     % noise matrix
P           =   diag(ones(1,6));                    % init state cov matrix

I           =   eye(6);

%% SPACE ALLOCATION
th      =   zeros(3,N);
om      =   zeros(3,N);
b       =   zeros(3,N);
th_b    =   zeros(3,N);
om_b    =   zeros(3,N);
Tc_b    =   zeros(3,N);
Pdiag   =   zeros(6,N);

%% MAIN LOOP
init_cond

if bias_noise==1
    theta_best      =   theta + v(:,1);
    omega_best      =   omega + bias_real;
else
    theta_best      =   theta;
    omega_best      =   omega;
end

thetadot_best   =   kinematics(n, theta_best, omega_best);

for k=1:N
    %% WRITE DATA
    th(:,k)         =   theta;
    om(:,k)         =   omega;
    b(:,k)          =   bias;
    th_b(:,k)       =   theta_best;
    om_b(:,k)       =   omega_best;
    Tc_b(:,k)       =   Tc;
    Pdiag(:,k)      =   diag(P);
        
    %% UPDATE KINEMATICS & DYNAMICS
    omegadot        =   dynamics(J, Td, Tc, n, theta, omega);
    thetadot        =   kinematics(n, theta, omega)';
    omega           =   euler_int(omega, omegadot, dt);
    theta           =   euler_int(theta, thetadot, dt);
    
    %% ADD BIAS & NOISE
    if bias_noise==1
        omega_m         =   omega + bias_real;
        theta_m         =   theta + v(:,k);
    else
        omega_m         =   omega;
        theta_m         =   theta;
    end
    
    %% COMPUTE BEST ESTIMATE
    if filter==1
        [theta_best, omega_best, bias, P]   =   ekf(bias, theta_best, omega_m, theta_m, P, dt, n, R, I);
    else
        theta_best      =   theta_m;
        omega_best      =   omega_m;
    end
    thetadot_best   =   kinematics(n, theta_best, omega_best)';

    %% COMPUTE CONTROL TORQUE
    Tc              =   control_torque(Kp, Kd, theta_best, thetadot_best)';
        
end  
        
%% PLOT
sim_plots