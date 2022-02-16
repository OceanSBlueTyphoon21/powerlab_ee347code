% EE347 - HW#4
% Student: Anthony Bruno
% Problem #1 - Transmission Lines (properties from ALCAN Tables)

clc
clear
format short
% Demonstration uses ALCAN Table - IBIS conductor
r = 0.0481;             % ohms per 1000ft
x_l = 0.0835;           % ohms per 1000ft
x_c = 0.539;            % Mohms per 1000ft
y_c = 1/x_c;            % MicroSiemens per 1000ft
GMR = 0.0265;           % in ft (GMR - Geometric Mean Radius, ALCAN)

% Transmission Line Characteristics:
tline_volt = 500000;    % in volts
tline_s = 150000000;    % in VA
tline_d = 95;           % in Miles
% The length is 95 Miles, which is roughly 152.88km 
% so the transmission Line Model should be Medium Transmission Line.

% Conductor Arrangement = Equilateral Triangle
tline_cond_space = 8;   % in ft

% Find the GMD (Geometric Mean Distance)
GMD = nthroot((8^3),3);

% operating Temperature
op_temp = 50;           % in Celsius

% Total Resistance
R_tot = r*tline_d*(5.28);       % There is 5.28 (1000ft) per mile

% Total Inductive Reactance
XL_tot = x_l*(5.28)*(tline_d)*log(GMD/GMR);

% Total Capacitive Admittance:
XC_tot = (x_c/(tline_d*5.28))*log(GMD/GMR);
YC_tot = 1/XC_tot;

% ABCD Parameters Calculations
% Calculate B
Z_m = complex(r,x_l)*(5.28)*(tline_d);      % In Ohms
B = Z_m;
% Calculate A and D
y = y_c * (10^-6); %microsiemens to Siemens
Y_m = complex(0,y)*(5.28)*(tline_d);   % Siemens
A = 1+ ((Z_m*Y_m)/2);
D = A;

%Calculate C
C = (Y_m)*((Z_m*Y_m)/4);


% Printing the Results:
fprintf('AC Resistance (Ohms per 1000ft):                 %4.4f\n',r)
fprintf('Total Resistance(Ohms):                          %4.3f\n',R_tot)
fprintf('Reactance (Ohms per 1000ft):                     %4.4f\n',x_l)
fprintf('Total Reactance(Ohms):                           %4.3f\n',XL_tot)
fprintf('Capacitive Admittance (MicroSiemens per 1000ft): %4.4f\n',y_c)
fprintf('Total Capacitive Admittance(MicroSiemens):       %4.3f\n',YC_tot)
fprintf('\n')

fprintf('A Coeff: %f + %fj\n',real(A),imag(A))
fprintf('B Coeff: %f + %fj\n',real(B),imag(B))
fprintf('C Coeff: %f + %fj\n',real(C),imag(C))
fprintf('D Coeff: %f + %fj\n',real(D),imag(D))