% CLASS docklands
Mass=100*1.0; %***
lambda=0.1;                    %0
inertial_mass=Mass*(1+lambda);
Davis=[1.376 0.0000072 0.0065 0];  %***  

Power=4*280000;   %***
max_speed=80*1;
seats=70;

%OHL to wheel and wheel to OHL
gen_rate= 0.85;      % Traction loss of 15%        
regen_rate=0.85;       % 0 - no regenerative braking

%MAXIMUM TRACTION FORCE
co_fric=0.2;
gravity=9.81;
driving_wheel_Po=Mass/2;
max_traction=Mass * 1000 * 9.81 * co_fric * (driving_wheel_Po/Mass)/1000;

%MAXIMUM ACCELERATION
max_accel=[max_traction/inertial_mass];

%proportional k
kd=0.5;

%notch numbers 5 or more
notch_num=5;
%train control
%1 = fast as possible
%2 = proportional
%3 = proportional and notched
train_control=1;
