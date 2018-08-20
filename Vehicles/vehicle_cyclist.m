% 80 kg cyclist with a 10 kg bike  Bradley wiggins Power!
Mass=0.080+0.01-0.0-0.0000
%456.000*1.3;
lambda=0.1;
inertial_mass=Mass*(1+lambda);
Davis=[0.004 0 0.00008 0];


Power=430
max_speed=90;
%260
seats=1;

%OHL to wheel and wheel to OHL
gen_rate= 0.85;      % Traction loss of 15%        
regen_rate=0;       % 0 - no regenerative braking

%MAXIMUM TRACTION FORCE
co_fric=0.5
gravity=9.81
driving_wheel_Po=Mass*0.5
max_traction=Mass * 1000 * 9.81 * co_fric * (driving_wheel_Po/Mass)/1000
%max_traction=204.319269;

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
train_control=2;
