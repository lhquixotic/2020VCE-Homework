%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vehicle Control Engineering Homework 1 Solution 1
% Author: Huiqian LI (2020310535)
% Date: 2020-10-06
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load Data
my_files = dir('Test_Data_Question 1\*.mat');
for i = 1:length(my_files)
    file_name{i} = strcat('Test_Data_Question 1\',my_files(i).name);
    %t=load(strcat('Test_Data_Question 1\',my_files(i).name));
    t{i} = load(file_name{i});
    field_name = fieldnames(t{i});
    test_data{i} = getfield(t{i},field_name{1});
end
% Test 1-4 are A2B(coast up), and test 5-8 are B2A.

% Plot test data
figure(1)
plot(test_data{1}(:,3),test_data{1}(:,2).^2,'.b','MarkerSize',1)
title('V_x^2  Vs  a_x')
xlabel('Longitudinal acceleration/(m/s^2)')
ylabel('Square of speed/(m/s)^2')

% Known Parameters
m = 1240;%kg
A = 1.87;%m^2
rho_air = 1.2;%kg/m^3
r = 0.3;%m
I_ws = 4.73;%kg·m^2
g = 9.8;%m/s^2

%% Solve 
for i = 1:8
    x_data = test_data{i}(:,3);
    y_data = test_data{i}(:,2).^2;
    polyfit_result = polyfit(x_data,y_data,1);
    k(i) = polyfit_result(1);
    b(i) = polyfit_result(2);
end

C_d = -2*(m+I_ws/r^2)/(rho_air*A*mean(k));
disp('Aerodynamic drag coefficient C_d is equal to '+string(C_d)+'.');
b_1 = mean(b(1:4));
b_2 = mean(b(5:8));
theta = asin((b_2-b_1)*C_d*A*rho_air/(4*m*g));
disp('Road slope gradient i is equal to ' + string(tan(theta))+'.');
f = -(b_1+b_2)*C_d*A*rho_air/(4*m*g*cos(theta));
disp('Rolling resistance coefficient f is equal to ' + string(f)+'.');

