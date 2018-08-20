% CLASS 150 DMU 
Mass=76.4;
lambda=0.08;
inertial_mass=Mass*(1+lambda);
Davis=[2.089488187 0.00983141 0.00650599 0];

Power=425*0.88*1000;
max_speed=75*1.6;
seats=124;

%OHL to wheel and wheel to OHL
gen_rate= 0.85;      % Traction loss of 15%        
regen_rate=0.;       % 0 - no regenerative braking

%MAXIMUM TRACTION FORCE
co_fric=0.1;
gravity=9.81;
driving_wheel_Po=Mass*0.5;
max_traction=Mass * 1000 * 9.81 * co_fric * (driving_wheel_Po/Mass)/1000;

%MAXIMUM ACCELERATION
max_accel=[max_traction/inertial_mass];

%proportional k
kd=1;

%notch numbers 5 or more
notch_num=5;

%train control
%1 = fast as possible
%2 = proportional
%3 = proportional and notched
train_control=1;
