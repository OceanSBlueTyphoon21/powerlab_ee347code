% Lab Team 1
% David Popa, Kevin Tran, Anthony Bruno
% Winter 2022
% Lab 4 - Engineering Design (8341 Transformer Module Model)
% File - TEST CASES Generator

clear
clc

fprintf('TEST 1 RESULTS \n')
% TEST 1:
[VR1,Eff1] = Trans8341Model(25,-45,1.05,0.95,1.05);
fprintf('Efficiency: %4.3f\n',Eff1);
fprintf('VR: %4.3f\n',VR1)
fprintf('\n')


