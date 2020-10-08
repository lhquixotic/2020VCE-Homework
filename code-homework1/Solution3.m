%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vehicle Control Engineering Homework 1 Solution 3
% Author: Huiqian LI (2020310535)
% Date: 2020-10-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Known Parameters
Ms = 1250; %kg
Ks = 44000; %N/m
Cs = 4000; %kg/s
Mu = 200; %kg
Ku = 400000; %N/m
Cu = 50; %kg/s

%% Plot
syms s;
G = (Cu*s+Ku)*(Cs*s+Ks)/((Cs*s+Ks)*Ms*s^2+(Mu*s^2+Cu*s+Ku)*(Ms*s^2+Cs*s+Ks));
%  (Cs*Cu*s^2 + (Cs*Ku + Cu*Ks)*s + Ks*Ku)/(Ms*Mu*s^4 + (Cs*Ms + Cs*Mu + Cu*Ms)*s^3 
%  + (Cs*Cu + Ks*Ms + Ks*Mu + Ku*Ms)*s^2 + (Cs*Ku + Cu*Ks)*s + Ks*Ku)
num = [Cs*Cu,(Cs*Ku+Cu*Ks),Ks*Ku];
den = [Ms*Mu,(Cs*Ms+Cs*Mu+Cu*Ms),(Cs*Cu+Ks*Ms+Ks*Mu+Ku*Ms),(Cs*Ku+Cu*Ks),Ks*Ku];
a1 = tf(num,den);
OP = bodeoptions;
OP.Grid = 'on';
OP.XLim = {[1 100]};
OP.XLimMode = {'manual'};
% OP.FreqUnits = 'Hz';
bode(a1,OP)
hold on
a2 = tf(1.1*num,den);
bode(a2,OP)
a3 = tf(0.9*num,den);
bode(a3,OP)