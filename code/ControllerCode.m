clc;clear
G1 = tf([1 11 418 0], [1 11 418 2000 25000]); %position
G2 = tf([8000 100000 0], [1 11.4 417.9 2000 25000]); %acceleration
G3 = tf([2000 25000 0], [1 11.4 417.9 2000 25000]); %force
Tf = 0.00122 / 100; %converting N to Tf for MATLAB
K = pid(0.0055, 0.1, 0.00122, Tf); %PID comp gains
gain = 25; %Gain K

%TFs
T_cl1 = feedback(G1 * K* gain, 1)
T_cl2 = feedback(G2 * K* gain, 1)
T_cl3 = feedback(G3 * K* gain, 1)

%Plot1position
sys = tf([2500 3.877e04 1.374e06 6.966e06 8.566e07 0], [1 8.448e04 9.408e05 3.564e07 1.709e08 2.135e09 0]);
t = linspace(0, 1, 1000);
subplot(3,1,1)
ystep = step(sys, t);
plot(t, ystep)
ylabel('Position')
title('Position vs. Time')
ylim([0 0.05]);
grid on
[y, t] = step(sys);
max(y); %Max x constraint

%Plot2acceleration
sys = tf([2e07 3.402e08 2.767e09 2.049e10 0], [1 8.198e04 2.094e07 3.745e08 2.931e9 2.254e10 0]);
subplot(3,1,2)
ystep = step(sys, t);
plot(t, ystep)
xlabel('Time, t, sec')
ylabel('Acceleration')
title('Acceleration vs. Time')
ylim([0 1.5]);
grid on
[y, t] = step(sys);
max(y); %Max a constraint

%Plot3force
sys = tf([5e06 8.505e07 6.917e8 5.123e09 0], [1 8.198e04 5.935e06 1.193e08 8.556e08 7.172e09 0]);
subplot(3,1,3)
ystep = step(sys, t);
plot(t, ystep)
ylabel('Force')
title('Force vs. Time')
grid on
ylim([0 1.5]);
[y, t] = step(sys);
max(y); %Max F constraint
