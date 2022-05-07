t   = (0:N-1)*dt;

th      = rad2deg(th);
om      = rad2deg(om);
b       = rad2deg(b);
th_b    = rad2deg(th_b);
om_b    = rad2deg(om_b);

lw      = 1.2;

figure(10)
plot(t, th_b, 'LineWidth', lw)
grid
xlabel('time (s)')
ylabel('angle (deg)')
legend('roll', 'pitch', 'yaw')
if bias_noise==0
    title('Attitude response under ideal conditions')
elseif filter==1
    title('Attitude with EKF')
else
    title('Attitude response under practical conditions')
end

figure(11)
plot(t, om_b, 'LineWidth', lw)
grid
xlabel('time (s)')
ylabel('rate (deg/s)')
legend('roll', 'pitch', 'yaw', 'Location', 'southeast')
if bias_noise==0
    title('Body rates response under ideal conditions')
elseif filter==1
    title('Body rates response with EKF')
else
    title('Body rates response under practical conditions')
end

figure(1)
hold on
plot(...
    t, th(1,:), ...
    t, th_b(1,:), ...
    'LineWidth', lw)
yline(0, 'k', 'linewidth', lw-.6)
grid
xlabel('time (s)')
ylabel('angle (deg)')
legend('actual roll','estimated roll', 'reference')
title('Roll estimation')

figure(2)
plot(...
    t, th(2,:), ...
    t, th_b(2,:), ...
    'LineWidth', lw)
yline(0, 'k', 'linewidth', lw-.6)
grid
xlabel('time (s)')
ylabel('angle (deg)')
legend('actual pitch','estimated pitch', 'reference')
title('Pitch estimation')

figure(3)
plot(...
    t, th(3,:), ...
    t, th_b(3,:), ...
    'LineWidth', lw)
yline(0, 'k', 'linewidth', lw-.6)
grid
xlabel('time (s)')
ylabel('angle (deg)')
legend('actual yaw','estimated yaw', 'reference')
title('Yaw estimation')

figure(4)
hold on
plot(...
    t, b, ...
    'LineWidth', lw)
yline(0.1, 'k', 'linewidth', lw-.6)
yline(-0.1, 'k', 'linewidth', lw-.6)
yline(0.15, 'k', 'linewidth', lw-.6)
grid
xlabel('time (s)')
ylabel('angle (deg)')
legend('roll bias', 'pitch bias', 'yaw bias', 'ground truth', 'Location', 'east')
title('Bias estimation with EKF')