# spacecraft-attitude-with-ekf

Implementation of an extended Kalman filter to improve accuracy of PD-controlled attitude maneuvering with biased and noisy sensor data.

- Spacecraft dynamics are implemented using first principles and considering first-order gravititational effects. 
- Sensor suite includes (biased) rate gyros and (noisy) attitude sensors for each vehicle axis.
- Bias is assumed to be non-drifting (constant) and noise is assumed to be Gaussian distributed.
