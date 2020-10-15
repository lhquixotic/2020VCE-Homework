%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vehicle Control Engineering Homework 2 Solution 2
% Author: Huiqian LI (2020310535)
% Date: 2020-10-14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Controlablility Matrix
A = [0,1;0,0];
B = [0;1];
Q_c = [B,A*B];
%% Solve
A = [pi^3/6,-pi^2/2;pi^2/2,-pi];
B = [-pi-2;-2];
lmd = A\B;
