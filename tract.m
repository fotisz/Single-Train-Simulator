%Compute Traction CURVE for display purposes only
%************************************************
v=1:1:max_speed;
v=v./3.6;
trac=Power./(v)/(inertial_mass*1000);
Res=zeros(1,length(v));
for i=1:length(v)
    if trac(1,i)>max_accel(1)
            trac(1,i)=max_accel(1);
    end
    Res(1,i)=Davis(1)+ v(1, i)*Davis(2) + (v(1, i))^2*Davis(3);
end

Res=Res./inertial_mass;
accel=trac-Res;