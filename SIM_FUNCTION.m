%This is the internal function of the STS
%It works out the acc, vel and time between each station seperately
%and then calculates force, power and energy for the whole route

for number=1:1:number_max-1
    
    r_min=route(number);
    r_max=route(number+1);
    r=r_min:del_S:r_max;
    
    %FORWARD VELOCITY CALCULATION
    
    for i=r_min/del_S+1 : r_max/del_S
        Resistance=(Davis(1)+Davis(2)*velF(1,i)+Davis(3)*(velF(1,i))^2)/inertial_mass;
        
        %INCLUDE IF train_control is not equal to 1
        if train_control==2
            prop
        end
        if train_control==3
            prop_notched
        end

        Traction(1,i)=Power*Elect(1,i)*vel_error(1,i)/(velF(1,i))/(inertial_mass*1000);
        if Traction(1,i)>max_accel(1)
            Traction(1,i)=max_accel(1);
        end
        accF(1,i+1)=Traction(1,i) - Resistance - grad_prof(1,i);
        
        if velF(1,i)<vel_limit(1,i+1)     %compares current vel to next limit
            velF(1,i+1)=(velF(1,i).^2+2*accF(1,i+1)*(del_S)).^0.5;
            if velF(1,i+1)>vel_limit(1,i+1)
                    velF(1,i+1)=vel_limit(1,i+1);
            end
        else
            if (accF(1,i+1)<0);
                velF(1,i+1) = (velF(1,i).^2+2*(accF(1,i+1))*(del_S)).^0.5;
                if velF(1,i+1)>vel_limit(1,i+1)
                    velF(1,i+1)=vel_limit(1,i+1);
                end
            else
                accF(1,i+1)=0;          % zero acceleration
                if vel_limit(i+1)==0    % if vel_limit = 0
                    velF(1,i+1)=0;      % then vel = 0
                else                    % otherwise velF is the same as previous
                    velF(1,i+1)=vel_limit(1,i);
                end
            end
        end
    end
    
    %BACKWARD VELOCITY CALCULATION
    
    count=0;
    i= r_max/del_S;
    Resistance=(Davis(1)+Davis(2)*velB(1,i+1)+Davis(3)*(velB(1,i+1))^2)/inertial_mass;
    accB(1,i)=Resistance + brake(velB(1,i+1), max_accel, Power*Elect(1,i), inertial_mass, Coasting, Coasting_vel)+ grad_prof(1,i+1);
    velB(1,i)=(velB(1,i+1)^2+2*accB(1,i)*(del_S))^0.5;
    
    
    for i= r_max/del_S-1:-1:r_min/del_S+2
        if velB(1,i+1)<vel_limit(1,i+1)
            Resistance=(Davis(1)+Davis(2)*velB(1,i+1)+Davis(3)*(velB(1,i+1))^2)/inertial_mass;
            accB(1,i)=Resistance + brake(velB(1,i+1), max_accel, Power*Elect(1,i), inertial_mass, Coasting, Coasting_vel)+ grad_prof(1,i+1);
            velB(1,i)=(velB(1,i+1)^2+2*accB(1,i)*(del_S))^0.5;
        else
            velB(1,i) = vel_limit(1,i+1);    % current vel = current vel limit
        end
    end
    
    %ACTUAL VELOCITY PROFILE
    for i=r_min/del_S + 1: r_max/del_S + 1 
        if velF(1,i)<=velB(1,i)
            acceler(1,i)=accF(1,i);
            vel(1,i)=velF(1,i);
        else
            acceler(1,i)=-accB(1,i);
            vel(1,i)=velB(1,i);
        end
    end      
    
    %DWELL ONLY SET AT STATIONS, SO ADDED ONTO EVERY NEW START
    %TIME CALCULATION
    i=r_min/del_S+1;           %adds dwell time to the first time from the station
    del_T(1,i+1)=2*del_S/(vel(1,i)+vel(1,i+1))+dwell(1,number);
    T(1,i+1)=T(1,i)+del_T(1,i+1);
        
    for i=r_min/del_S+2:r_max/del_S                        
            del_T(1,i+1)=2*del_S/(vel(1,i)+vel(1,i+1));
            T(1,i+1)=T(1,i)+del_T(1,i+1);
    end
end   


%Calculate traction force, power and energy for the whole route

%TRACTION (F-forward B-backward) CALCULATION
    % work out Notch until the very end of route - final Notch is always zero
    for i=2:Size-1       
        Resistance=(Davis(1)+Davis(2)*vel(1,i)+Davis(3)*(vel(1,i))^2)/inertial_mass; 
        % remove average with next acceleration value
        % +acceler(1,i+1))/2
        Notch(1,i)=(acceler(1,i)...
            + Resistance + grad_prof(1,i))...
            *inertial_mass*1000;
        if Notch(1,i)>0
            TractionB(1,i)=0;
            if Notch(1,i) > max_traction*1000
                TractionF(1,i) = max_traction*1000;
            else
                TractionF(1,i)=Notch(1,i);
            end
        else
            TractionF(1,i)=0;
            TractionB(1,i)=-Notch(1,i);
        end
    end
    
    %Energy and Power*Elect(1,i)(F-forward B-backward) CALCULATION
    %Braking energy is partitioned into that used by the motors and that by
    %the mechanical brake system
    for i=2:Size-1
        if vel(1,i)==0
            EnergyF(1,i)=0;
            PowerF(1,i)=0;
            
            EnergyB(1,i)=0;
            PowerB(1,i)=0;
        else
            EnergyF(1,i)=TractionF(1,i)*del_S;
            PowerF(1,i)=TractionF(1,i)*vel(1,i);
                if PowerF(1,i)>Power*Elect(1,i)
                    PowerF(1,i)=Power*Elect(1,i);
                    EnergyF(1,i)=PowerF(1,i)/vel(1,i)*del_S;
               
                end

            EnergyB(1,i)=TractionB(1,i)*del_S;
            EnergyB_mech(1,i)=0;
            PowerB(1,i)=TractionB(1,i)*vel(1,i);
            PowerB_mech(1,i)=0;
                if PowerB(1,i)>Power*Elect(1,i)
                    PowerB_mech(1,i)=PowerB(1,i)-Power*Elect(1,i);
                    EnergyB_mech(1,i)=PowerB_mech(1,i)/vel(1,i)*del_S;
                    PowerB(1,i)=Power*Elect(1,i);
                    EnergyB(1,i)=PowerB(1,i)/vel(1,i)*del_S;
                end
        end
    end
 

