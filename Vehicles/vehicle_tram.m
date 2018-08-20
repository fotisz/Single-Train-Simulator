%Typical modern Tram Based roughly on CAF URBOS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
Davis=[1.0848 0.007819*3.6 0.0006205*3.6*3.6]; %AW0
Mass=56.85+23.61; %AW2
lambda=0.08;
inertial_mass=Mass*(1+lambda);

%OHL to wheel and wheel to OHL
gen_rate= 0.85;      % Traction loss of 15%        
regen_rate=0.85;       % 0 - no regenerative braking

Power=904000;
max_speed=60;
seats=260;

%MAXIMUM TRACTION FORCE
max_traction=105;   
gravity=9.81;

%MAXIMUM ACCELERATION
max_accel=[max_traction/inertial_mass];

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