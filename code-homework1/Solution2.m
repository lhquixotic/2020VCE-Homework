%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vehicle Control Engineering Homework 1 Solution 2
% Author: Huiqian LI (2020310535)
% Date: 2020-10-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Known Parameters
m = 1818; %kg
Izz = 3885; %kgm^2
a = 1.463; %m
b = 1.585; %m
k1 = -62618; %N/rad
k2 = -110185; %N/rad

%% (1)Draw the step response of lateral speed and yaw rate
u = 50;
A = [(k1+k2)/(m*u), (a*k1-b*k2)/(m*u)-u;
      (a*k1-b*k2)/(Izz*u), (a^2*k1+b^2*k2)/(Izz*u)];
B = [k1/m;k1*a/Izz];
C_lat = [1 0]; D_lat = 0;
C_yaw = [0 1]; D_yaw = 0;

C = [C_lat;C_yaw]; D = [D_lat;D_yaw];

t0 = 20;dt = 0.01;
front_wheel_angle = 10; %deg
t = [0:dt:t0];
U = [zeros(1,t0/dt/4),ones(1,3*t0/dt/4+1)]/180*pi*front_wheel_angle;
Y = lsim(A,B,C,D,U,t);

figure(1)
subplot(3,1,1)
plot(t,U*180/pi,'b','LineWidth',1.5)
% axis([0,10,-0.2,1.2])
% axis([0 15 -2 front_wheel_angle+2])
ylabel('Steering angle(deg)')
grid on
subplot(3,1,2)
plot(t,Y(:,1),'b','LineWidth',1.5)
% axis([0,10,-2,6])
% axis([0 15 -0.4 1])
ylabel('Lat. speed(m/s)')
grid on
subplot(3,1,3)
plot(t,Y(:,2)*180/pi,'b','LineWidth',1.5)
% axis([0,10,-4,0.5])
% axis([0 15 -40 5])
xlabel('time/s')
ylabel('Yaw rate(deg/s)')
grid on

%% (2) Derive the natural frequence and damping rate
syms k1 k2 m u a b Izz;
a11 = (k1+k2)/(m*u);
a12 = (a*k1-b*k2)/(m*u)-u;
a21 = (a*k1-b*k2)/(Izz*u);
a22 = (a^2*k1+b^2*k2)/(Izz*u);

natural_frequency = sqrt(a11*a22-a12*a21);
damping_rate = -(a11+a12)/(2*natural_frequency);
