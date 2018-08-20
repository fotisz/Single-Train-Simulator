                                                                                                                                                                                                                                                                                                                                                                                         Mass=56.85+23.61; %AW2
lambda=0.07;
Davis=[1.0848 0.007819*3.6 0.0006205*3.6*3.6]; %AW0
inertial_mass=Mass;

formation=6;
trainset=1;
tra_fix=1.5;
accB_fix=1.5;
gen_rate=0.85;
regen_rate=0;
Coasting_vel=80*1.6/3.6;

Power=904000;
max_speed=80;
seats=260;

%MAXIMUM TRACTION FORCE
max_traction=105;   
gravity=9.81;

%MAXIMUM ACCELERATION
max_accel=[max_traction/Mass];

%STATION DWELL TIME (Seconds)
dwell=30;

%STATION TERMINAL TIME (Seconds)
Terminal_time=15*60;

%proportional k
kd=0.8;

%notch numbers
notch_num=7;

%train control
%1 = fast as possible
%2 = proportional
%3 = proportional and notched
train_control=1;