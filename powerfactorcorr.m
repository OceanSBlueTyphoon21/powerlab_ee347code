function [Q_c] = powerfactorcorr(P,Q_l)
%powerfactorcorr Determines the required reactive power (Q_c MVA) for given
%load in order to generate a PFC within 0.95 to 1.0
%  Description:
%  This function uses the Real Power (P in Mega-Watts) and Reactive Power
%  (Q_l in Mega-VAr) in order to calculate the required reactive power 
%  (Q_c) in order for the apparent power load to have a corrected Power
%  Factor (PF) between 0.95 < pf < 1.0. The function returns the reactive
%  power Q_c if the Magnitude of the apparent power (S_load) is not greater
%  than 10MVA. If the Magnitude of S_load > 10MVA, it returns NaN. Else,
%  the function returns a single Q_c value with a Power Factor between 0.95
%  and 1.0.
%  INPUTS: 
%       - P   : Real Power of S_Load (in Mega-Watts)
%       - Q_l : Reactive Power of S_Load (in Mega-VAr)
% Note: S_Load = P + j * Q_l
%       Moreover, the Power Factor Correction is based on a Parallel
%       Capacitor with the given S_load. The Q_c returned is postive 
%       but the true Q_c value would be negative. This function simply
%       expresses the magnitude of the value. In circuits, this value
%       should be negative for evaluation of a circuit.
%
%  OUTPUTS:
%       - Q_c : Required Reactive Power in order to corrected the S_Load
%               Power Factor to a value between 0.95 and 1.0
% Note: The Q_c value is in increments of 0.25MVAr and is an average value.

% ----------------------- MAIN FUNCTION PROGRAM ------------------------
s_mag = sqrt((P^2)+(Q_l^2));                                        % Determine the S_Load Magnitude
if floor(s_mag) > 10                                                % Conditional statement for checking the S_load Magnitude
    Q_c = NaN;                                                      % Return a NaN is S_load Mag. > 10MVA
else
    qc_total=0;                                                     % qc_total for summation of all q_c
    for pf = 0.95:0.01:1.0                                          % For Loop finds a q_c from looped pf
        q_c = Q_l - ((P/pf)*sin(acos(pf)));                         % Function to generate the q_c for a given pf & S_load
        qc_total = qc_total + q_c;                                  % Add the q_c to qc_total (summation)
    end
    qc_ave = qc_total/6;                                            % Determine the qc_ave (average Q_c value)
    qc_re = double(floor(qc_ave) + floor((qc_ave-floor(qc_ave))/0.25)*0.25);  % Round down the Q_c value and return to mainline
    if qc_re < 0
        Q_c = 0;
    else
        Q_c = qc_re;
    end
end
end

