% Contour Script
% This script uses the powerfactorcorr() function to generate a 3D 
% contour of Q_c = f(P,Q_l) where a given S_load = P + j*Q_l.
% EE 347 - Lab 2 (Winter 2022)
% Group 1: Anthony Bruno, David Popa, Kevin Tran

clear
clc

P   = 1:0.01:10;
QL= 0:0.01:10;

P_len = length(P);
Q_len = length(QL);

s_mat = zeros(P_len,Q_len);

for row = 1:1:P_len
    for col = 1:1:Q_len
       s_mat(row,col)=complex(P(row),QL(col));
    end
end

qc_mat = zeros(P_len,Q_len);

for row = 1:1:P_len
        for col = 1:1:Q_len
            qc_mat(row,col)=powerfactorcorr(real(s_mat(row,col)),imag(s_mat(row,col)));
        end
end

plot3(real(s_mat),imag(s_mat),qc_mat)
title('Qc needed for PF correction')
xlabel('Real power P (MW)')
zlim([0 10])
ylabel('Reactive Power Q (MVar)')
zlabel('Reactive Power Qc (MVar)');grid on