% CLASS 14x DMU
Mass=49.5
lambda=0.08;            %0.08;
inertial_mass=Mass*(1+lambda);
Davis=[1.35379143 0.006369827 0.004215268 0]

Power=334*0.7*1000;
max_speed=75*1.6;
seats=121;

%OHL/diesel to wheel and wheel to OHL
gen_rate= 0.85;      % Traction loss of 15%        
regen_rate=0.;       % 0 - no regenerative braking

%MAXIMUM TRACTION FORCE
co_fric=0.1
gravity=9.81
driving_wheel_Po=Mass*0.5
max_traction=Mass * 1000 * 9.81 * co_fric * (driving_wheel_Po/Mass)/1000

%MAXIMUM ACCELERATION
max_accel=[max_traction/Mass]

% FOR DIFFERENT TRAIN CONTROL
%proportional k
kd=0.5;

%notch numbers 5 or more
notch_num=5;

%train control
%1 = fast as possible
%2 = proportional
%3 = proportional and notched
train_control=1;
