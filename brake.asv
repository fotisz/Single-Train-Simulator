function [b] = brake(vel, max_accel, Power, inertial_mass, Coasting, Coasting_vel)

if Coasting == 1
        if vel >= (Coasting_vel/3.6)
        b=0;           
        else
        b=Power/inertial_mass/1000/vel;
            if b>max_accel
                b=max_accel;
            end
            b=0.75;
        end
else
    b=Power/inertial_mass/1000/vel;
    if b>max_accel
        b=max_accel;
    end
    b=0.75;
end
%comment out the line below if you wish the train to brake using constant
%power
%b=1.3;