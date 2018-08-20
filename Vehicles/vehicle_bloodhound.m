% Bloodhound
Mass=8
%456.000*1.3;
lambda=0.1;
inertial_mass=Mass*(1+lambda);
Davis=[0.01 0 0.0007 0];

Power=88000000
max_speed=1600;
%260
seats=1;

%OHL to wheel and wheel to OHL
gen_rate= 0.85;      % Traction loss of 15%        
regen_rate=0;       % 0 - no regenerative braking

%MAXIMUM TRACTION FORCE

max_traction=200;
gravity=9.81;

%MAXIMUM ACCELERATION
max_accel=[max_traction/inertial_mass];

%proportional k
kd=0.1;

%notch numbers
notch_num=5;

%train control
%1 = fast as possible
%2 = proportional
%3 = proportional and notched
train_control=1;
