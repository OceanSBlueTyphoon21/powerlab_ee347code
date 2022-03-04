function [VR,Eff,ocf,uvf,ovf] = Trans8341Model(S_load,theta_d,C_i,Vu,Vo)
%Trans8341Model - Returns the VR% and Efficiency (%) for a given S_load on
%                 the Lab Volt 8341 Fully Protected Transformer Module. 
%   Given an |S_load| and a theta of the load, this function is able 
%   to calculate the Voltage Regulation (Load regulated) and the efficiency
%   of the 8341 Transformer module in the PSU ECE Power Lab. In addition,
%   the function is able to detect if there is an overcurrent in the line and
%   overvoltage or undervoltage on the primary side of the transformer.
%   These detections are displayed in text when a system is ran using this
%   simulation model. The main goal of this function is to simulate the
%   8341 Transformer model and understand its performance when under a
%   specific load.

% USER MANUAL -----------------------------------------------------------
% FUNCTION NAME: Trans8341Model()
% SYNTAX: 
%           [Voltage_Regulation, Efficiency] = Trans8341Model(|S_load|,theta,C_i,Vu,Vo)

% Description: Returns the Voltage Regulation Percent and Efficiency
% Percent of the Lab Volt 8341 Single Phase transformer module given a
% load's apparent power magnitude (|S_load|) and the load's theta (related
% to Power Factor of the load)

% INPUTS:
%   - S_load: the Magnitude of the apparent power of a load on the Lab Volt
%             8341 Transformer Module.
%   - Theta: The theta (in degrees) of the apparent power of a load on the
%            Lab Volt 8341 Transformer Module. PF = Cos(theta).
%   - C_i: The Overcurrent factor in Per-unit (scaling factor of I_rated of
%          the Transformer module.
%   - Vu: Undervoltage factor in Per-unit. Used to detect if the Vp of the
%         transformer is under a specified voltage.
%   - Vo: Overvoltage factor in Per-unit. Used to detect if the Vp of the
%         transformer is overvoltage.

% OUTPUTS:
%   - VR: load-regulatd Voltage Regulation of 8341 Transformer, expressed as percentage
%   - Eff: Efficiency of 8341 Transformer, expressed as percentage
%   - ocf: Overcurrent flag --> True if |I_line| >= c_i*(I_rated)
%   - uvf: undervoltage flag --> True if |Vp| <= vu*(Vrated)
%   - ovf: overvoltage flay --> True if |Vp| >= vo*(Vrated)

% EXAMPLES:
%           [VR1,Eff1,ocf,uvf,ovf] = Trans8341Model(60,32,1.1,0.95,1.05)
% 
% Return:
%       Over-voltage Detected!
%       VR1 = 10.0778
%       Eff1 = 87.9645
%       ocf = 0
%       uvf = 0
%       ovf = 1

% -----------------------------------------------------------------


theta_r = deg2rad(theta_d); % Used to convert Load theta (degrees) to Load theta (rad.)

% SC & OC Tests: (Reference: Table 1 from EE347 Lab 4 report)
V_oc = 120.3;       % Open-circuit test voltage
I_oc = 0.028;       % Open-circuit test current
P_oc = 2.165;       % Open-circuit test power
V_sc = 14.55;       % Short-circuit test voltage
I_sc = 0.505;       % Short-circuit test current
P_sc = 4.389;       % Short-circuit test power

% Cantilever Equiv. Circuit: (Reference: Figure 2 from EE347 Lab 4 report)
Req = 17.2;         % Req,p
Xeq = 23.1;         % Xeq,p
Rcore = 6670;       % Rcore
Xm = 5610;          % Xm


% Return the VR% ---------------------------------------------
% No Load Conditions: ++++++++++++++++++
Vp_nl = V_oc;        % Vp_no load = V_open circuit = aVs

% Full load Condition: ++++++++++++++++++
% find Is/a
Is_mag = S_load./V_oc;       % Mag. of Is/a
Is_phase = -theta_r;        % Phase of Is/a
a = (Is_mag).*cos(Is_phase); % real part of Is/a
b = (Is_mag).*sin(Is_phase); % Imaginary part of Is/a

Is_a = complex(a,b);        % Is/a = a+jb

% Zeq,p
Zeq = complex(Req,Xeq);     % Zeq,p = Req,p + j*Xeq,p

% Vp_fl Magnitude
Vp_fl = (Zeq.*Is_a)+ complex(V_oc,0);    % Vp_full load = V_series + aVs
                                        % V_series = Zeq,p*Is/a, aVs = Voc
vp = Vp_fl;     % For under/over voltage detection

% VR% find
VR = ((abs(Vp_fl) - abs(Vp_nl))/abs(Vp_fl)).*100;

% Return Eff%-----------------------------------------

Pout = S_load.*cos(theta_r);
Pcu = ((abs(Is_a)).^2)*Req;          % Power loss in windings
Pcore = ((abs(Vp_fl)).^2)./Rcore;     % Power loss in core of Transformer

Eff = (Pout/(Pout + Pcu + Pcore)).*100;


% DETECTION FLAGS
% initialize Detection flags/Triggers
ocf = 0;
uvf = 0;
ovf = 0;

% Overcurrent trigger - Triggers if the current in Is/a is too high!
octrigger = C_i.*I_sc;
if abs(Is_a)>= octrigger
    %disp('Overcurrent Detected!')
    ocf = 1;
end

% Over/Under Voltage Trigger Limits
ovtrigger = Vo.*V_oc;
uvtrigger = Vu.*V_oc;


if abs(Vp_fl)>= ovtrigger
    %disp('Over-voltage Detected!')  % Triggers if Vp exceeds ovtrigger limit
    ovf = 1;
end

if abs(Vp_fl) <= uvtrigger
    %disp('Under-voltage Detected!') % Trigger is Vp is below uvtrigger limit
    uvf = 1;
end

end
