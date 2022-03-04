% Lab Team 1
% David Popa, Kevin Tran, Anthony Bruno
% Winter 2022
% Lab 4 - Engineering Design (8341 Transformer Module Model)
% File - TEST CASES

clear 
clc

s_load = [60;75;60;108;108;55;60;60;25];
s_theta = [32;-75;-65;-75;75;78;32;-32;-45];
c_i = [1.1;1.1;1.1;1.1;1.1;1.05;1.1;1.05;1.05];
vu = [0.9;0.9;0.95;0.95;0.95;0.8;0.92;0.95;0.95];
vo = [1.1;1.1;1.05;1.05;1.05;1.05;1.12;1.05;1.05];

% Tests
[VR1,Eff1,ocf1,uvf1,ovf1] = Trans8341Model(60,32,1.1,0.9,1.1);
[VR2,Eff2,ocf2,uvf2,ovf2] = Trans8341Model(75,-75,1.1,0.9,1.1);
[VR3,Eff3,ocf3,uvf3,ovf3] = Trans8341Model(60,-65,1.1,0.95,1.05);
[VR4,Eff4,ocf4,uvf4,ovf4] = Trans8341Model(108,-75,1.1,0.95,1.05);
[VR5,Eff5,ocf5,uvf5,ovf5] = Trans8341Model(108,75,1.1,0.95,1.05);

% Random Values for checking
[VR6,Eff6,ocf6,uvf6,ovf6] = Trans8341Model(s_load(6),s_theta(6),c_i(6),vu(6),vo(6));
[VR7,Eff7,ocf7,uvf7,ovf7] = Trans8341Model(60,32,1.1,0.92,1.12);
[VR8,Eff8,ocf8,uvf8,ovf8] = Trans8341Model(60,-32,1.05,0.95,1.05);
[VR9,Eff9,ocf9,uvf9,ovf9] = Trans8341Model(25,-45,1.05,0.95,1.05);

VR = [VR1;VR2;VR3;VR4;VR5;VR6;VR7;VR8;VR9];
Eff = [Eff1;Eff2;Eff3;Eff4;Eff5;Eff6;Eff7;Eff8;Eff9];

Ocf = logical([ocf1;ocf2;ocf3;ocf4;ocf5;ocf6;ocf7;ocf8;ocf9]);
Uvf = logical([uvf1;uvf2;uvf3;uvf4;uvf5;uvf6;uvf7;uvf8;uvf9]);
Ovf = logical([ovf1;ovf2;ovf3;ovf4;ovf5;ovf6;ovf7;ovf8;ovf9]);

% Display Results Table
T = table(s_load,s_theta,c_i,vu,vo,VR,Eff,Ocf,Uvf,Ovf)
