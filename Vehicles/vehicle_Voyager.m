% CLASS 220 4 car
Mass=213.19;
lambda=0.08;    
inertial_mass=Mass*(1+lambda);
Davis=[3.4537 0.0767 0.0043 0]; 

Power=560*4*1000;
max_speed=200;
seats=188;

%OHL to wheel and wheel to OHL
gen_rate= 0.85;      % Traction loss of 15%        
regen_rate=0;       % 0 - no regenerative braking

%MAXIMUM TRACTION FORCE
co_fric=0.13;
gravity=9.81;
driving_wheel_Po=Mass*0.5;
%Mass/2
max_traction=Mass * 1000 * 9.81 * co_fric * (driving_wheel_Po/Mass)/1000;

%MAXIMUM ACCELERATION
max_accel=[max_traction/Mass];

%proportional k
kd=0.5;

%notch numbers 5 or more
notch_num=5;

%train control
%1 = fast as possible
%2 = proportional
%3 = proportional and notched
train_control=1;
