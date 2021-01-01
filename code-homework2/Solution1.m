%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vehicle Control Engineering Homework 2 Solution 1
% Author: Huiqian LI (2020310535)
% Date: 2020-10-14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Transfer Function
% syms s;
% P = 10/((s+1)*(s+5)*(s+10));
% syms kp ki kd;
% G = kp + ki/s + kd*s;
% Gc = G*P/(1+G*P);
% Gc = (10*kd*s^2 + 10*kp*s + 10*ki)/(10*ki + 50*s + 10*kp*s + 10*kd*s^2 + 65*s^2 + 16*s^3 + s^4);
% Gc = (10*kd*s^4 + (150*kd + 10*kp)*s^3 + (500*kd + 10*ki + 150*kp)*s^2 + (150*ki + 500*kp)*s + 500*ki)
% /(10*kd*s^4 + (150*kd + 10*kp)*s^3 + (500*kd + 10*ki + 150*kp + 1)*s^2 + (150*ki + 500*kp + 1)*s + 500*ki)

% Initially we choose the parameters by intuition 1,0.1,0->15,0.8,0.2
kp = 20; 
ki = 1 * kp; 
kd = 0 * kp;
num = [10*kd, 10*kp, 10*ki];
den = [1, 16, 65+10*kd, 10*kp+50, 10*ki];
sys = tf(num,den);
poles = roots(den)
zeros = roots(num)
%% Plot
% figure
% Plot Pole-Zero Map
% subplot(211)
% pzmap(sys);
t = 0:0.02:20;
h = step(num,den,t);
% Plot Step Response
% subplot(212)
plot(t,h,'LineWidth',1.2)
title('Step Response of Closed Loop Plant');
xlabel('Time/s');
hold on