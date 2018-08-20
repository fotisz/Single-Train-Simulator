% CLASS Pendoloino
Mass=592.8    
%456.000*1.3;
lambda=0.1;
inertial_mass=Mass*(1+lambda);
Davis=[5.421599486 0.069031701 0.0103098948 0];

%OHL to wheel and wheel to OHL
gen_rate= 0.85;      % Traction loss of 15%        
regen_rate=0.85;       % 0 - no regenerative braking

Power=6000000; %traction power at wheels
max_speed=200;
%260
seats=439;


%MAXIMUM TRACTION FORCE
co_fric=0.0703
gravity=9.81
driving_wheel_Po=Mass*0.5
% max_traction=Mass * 1000 * 9.81 * co_fric * (driving_wheel_Po/Mass)/1000*10
max_traction=204.319269;

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
