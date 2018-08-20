%rail sim computation
%space discretisation
%The code belongs to the University of Birmingham BCRRE
%**************************************************************
clear all
%LOAD VEHICLE MODEL:
%Uncomment 1 vehicle model below
vehicle_Pendolino
%vehicle_IC125
%vehicle_Voyager
%vehicle_DLR
%vehicle_Class14x
%vehicle_Class150_original
%vehicle_tram 
%vehicle_cyclist  %example of a powerful cyclist - included in the code for fun
%vehicle_bloodhound  %The 1000 mph car - included in the code for fun
%**************************************************************

%LOAD INPUT FILES:
%Uncomment 1 route below.  The first file are very simple.
%Get to know this file first
%load route_simple_gradient
%load route_simple_speed
%load route_simple_stations
%load route_simple
%load route_hakskeen
%load route_Birmingham_whole_day
%load route_Birmingham_whole_day_ECS  %empty coaching stock
%load route_Docklands
%load route_Euston_MK_Rugby
%load route_Euston_MK_Rugby_200
load route_Euston_MK_Rugby_100
%load route_Euston_MK_Rugby_ES  %ES - enhanced line speed
%load route_Euston_Rugby
%load route_KingsX_NewC_KingsX
%load route_KingsX_NewC_KingsX_whole_day
%load route_MoorStreet_Stratford_MoorStreet
%load route_Padd_BristolTM_Padd
%load route_Padd_BristolTM_Padd_whole_day
%load route_Stratford_Moorstreet
%load route_Trehafod_Treherbert
%load route_Valleys_whole_day
%load route_Valleys_whole_day_ECS %empty coaching stock
%load route_wolverton_rugby
%load 
%**************************************************************

%COMPUTE TRACTION CURVES:
tract;

%students can modify code below
% if coasting = 0, no coasting applied. if coasting is 1, the vehicle will
% only start braking when it reaches coasting_vel (if possible)
% Coasting vel is in km/h

Coasting = 0;
Coasting_vel=60;             

%DEFINE TRACK DOMAIN S is the distance variable
S_min=0;
S_max=max(vel_profile(:,1))*1000;

del_S=1;            %This is the distance step keep at 1 metre
s=S_min:del_S:S_max;
Size=length(s);

%DEFINE ARRAYS
vel_limit=zeros(1, Size);
line_vel_limit=zeros(1, Size);
grad_prof=zeros(1, Size);
TractionF=zeros(1, Size);
TractionB=zeros(1, Size);
Elect=ones(1,Size);
EnergyF=zeros(1, Size);
EnergyB_mech=zeros(1, Size);
EnergyB=zeros(1, Size);
PowerF=zeros(1, Size);
PowerB=zeros(1, Size);
PowerB_mech=zeros(1, Size);
Notch=zeros(1, Size);
acceleration=zeros(1, Size);
acceler=zeros(1, Size);
accF=zeros(1, Size);
accB=zeros(1, Size);
jerk=zeros(1, Size);
T=zeros(1, Size);
T_F=zeros(1, Size);
vel=zeros(1, Size);
del_T=zeros(1, Size);
velF=zeros(1,Size);
velB=zeros(1,Size);
counter=0;

%If train_control=1, pre-allocate matrix values
if train_control==1
    vel_error=zeros(1, Size)+1;
else
    vel_error=zeros(1, Size);
end

%DETERMINE VEL LIMIT FROM INPUT FILE
pos=2;
for i=1:Size-1
    vel_limit(1,i)=vel_profile(pos-1,2)/3.6;
    line_vel_limit(1,i)=vel_limit(1,i);
    if vel_limit(1,i)>=max_speed/3.6
        vel_limit(1,i)=max_speed/3.6;
    end
    if i*del_S>=fix(vel_profile(pos,1)*1000)
        pos=pos+1;
    end
end


%DETERMINE ELECTRICATION LOCATIONS FROM INPUT FILE
%checks for the existance of the elect variable in the route file
if exist('elect')
pos=2;
for i=1:Size-1
    Elect(1,i)=elect(pos-1,2);
    if i*del_S>=fix(elect(pos,1)*1000)
        pos=pos+1;
    end
end
end

pos=2;
for i=1:(fix(1000/del_S*max(gradient(:,1))))
    grad_prof(1,i)=gradient(pos-1,2)/1000*gravity/(1+lambda);
    if i*del_S>=fix(gradient(pos,1)*1000)
        pos=pos+1;
    end
end
grad_prof(1,i+1)=grad_prof(1,i);

%DETERMINE STATION, TERMINAL STOPS & DWELL FROM INPUT FILE
% the dwell time for the station and terminal stops should be included in
% the second column of station_info to allow for variable dwell at stations
done=0;
number=1;
x=size(station_info);      % determine the size of the station info matrix

% sets the distance of the station stops
route(number)=0;           % set the first station distance to zero
dwell(number)=0;           % set first dwell to zero

if station_info(number)~=0 % if the first station distance in the file is not zero
    n=-1;                  % n=1, so the distances are set 
else
    n=0;
end
    while done~=1
        number=number+1;
        if station_info(number)==0   % exit the loop if the station distance = 0
            done=1;
            number_max=number-1;
        elseif number==x(1,1)        % exit the loop if the last entry in station_info has been read
            done=1;
            route(number)=(fix(station_info(number+n,1)*1000/del_S))*del_S;
            dwell(number)= station_info(number+n,2);
            vel_limit(route/del_S+1)=0;
            number_max=number;              %set the vel limit at the stations to zero
        else
            route(number)=(fix(station_info(number+n,1)*1000/del_S))*del_S;
            dwell(number)= station_info(number+n,2);
            vel_limit(route/del_S+1)=0;
        end
    end
if route(number_max)~= (fix(S_max/del_S))*del_S   %set the last station at the end of the route
    number_max = number_max+1;
    route(number_max)= (fix(S_max/del_S)*del_S);
end
dwell(number_max)= 0;      %set last dwell to zero

% clear unnecessary variables
clear done i n number pos x
tic
%Run the STS function from a separate m file
SIM_FUNCTION;   
toc 
%calculates the energy and power for the route
energy_calcs

% runs plot files
plotter_all;
