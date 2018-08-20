% Energy calculated below to include efficiency: Power is in Watts
PowerF_pan=PowerF/gen_rate;
EnergyF=EnergyF/gen_rate;  %energy in at pantograph
EnergyF_lost=EnergyF - EnergyF*gen_rate;
PowerB_pan=PowerB*regen_rate;
EnergyB=EnergyB*regen_rate;  %energy returned to pantograph
EnergyB_lost=EnergyB-EnergyB/regen_rate; %electrical energy lost in converters etc
kWh_Mech_F=sum(EnergyF)/3.6/1000000;
kWh_Mech_B=sum(EnergyB)/3.6/1000000;
energyall=kWh_Mech_F-(kWh_Mech_B); %this is the overall consumption for the route
journey_time=max(T);

% calculate kinetic, potential and resistance energy  units are kWh
height;
kinetic_energy=1/2*inertial_mass.*vel.*vel*1000/3.6/1000000;
potential_energy=altitude*9.81*Mass/3.6/1000;
resistance_energy= cumsum((Davis(1)+Davis(2).*vel+Davis(3).*(vel.^2)).*del_S)*1000/3.6/1000000;
energy_consumed=(cumsum(EnergyF)-cumsum(EnergyB))/3.6/1000000;
Traction_energy_pan=cumsum(EnergyF)/3.6/1000000;
Regen_energy_pan=cumsum(EnergyB)/3.6/1000000;
energy_lost_traction=(cumsum(EnergyF_lost))/3.6/1000000;
energy_lost_braking=-(cumsum(EnergyB_lost))/3.6/1000000;
energy_lost_braking_mech=(cumsum(EnergyB_mech))/3.6/1000000;
kg_hydrogen_approx=energy_consumed*3600000/150000000/2;
energy_audit=kinetic_energy+potential_energy+ resistance_energy+energy_lost_traction+energy_lost_braking +energy_lost_braking_mech;
