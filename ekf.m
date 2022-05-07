function [theta_best, omega_best, bias, P] = ekf(bias, theta, omega_m, theta_m, P, dt, n, R, I)
    %% STATE VECTOR
    x   =   [ theta ; bias ];
    u   =   omega_m;

    %% JACOBIANS
    [F, H]      =   jacobians(n, x, u);
    Phi         =   expm(F*dt);
    
    %% PREDICTION
    xdot        =   kinematics2(n, x, u)';
    P_pred      =   Phi * P * Phi';
    x_pred      =   euler_int(x, xdot, dt);

    %% CORRECTION
    K           =   P_pred * H' /( H * P_pred * H' + R );
    x_corr      =   x_pred + K * (theta_m - H*x_pred);    
    P_corr      =   (I - K * H) * P_pred * (I - K * H)' + K * R * K';
    
    %% OUTPUT
    theta_best  =   x_corr(1:3);
    bias        =   x_corr(4:6);
    omega_best  =   u - x_corr(4:6);
    P           =   P_corr;
    
    
    
    
    
    
    