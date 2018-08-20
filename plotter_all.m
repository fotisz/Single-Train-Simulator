height
figure(1)
%scrsz = get(0,'ScreenSize');
%set(1, 'Position', [1 scrsz(4) scrsz(3) scrsz(4)] )
%PLOTS AND OUTPUTS
% subplot(2,3,1), plot(s/1000, -grad_prof/9.81, 'r')
% hold on
subplot(2,3,1), plot(s/1000,altitude, 'k')
% xlabel('distance (km)')
% ylabel('altitude (m)')
subplot(2,3,1), title(' altitude')
subplot(2,3,1), xlabel('distance (km)')
subplot(2,3,1), ylabel('(m)')
% subplot(2,3,1), ylabel('gradient slope %')
%******************
subplot(2,3,2), plot(s./1000, vel*3.6, 'r')
hold on 
subplot(2,3,2), plot(s./1000, line_vel_limit*3.6, 'k')
%subplot(2,3,2), plot(s, velB, 'b')
subplot(2,3,2), title('Velocity profile')
subplot(2,3,2), xlabel('distance (km)')
subplot(2,3,2), ylabel('(km/h)')
%******************
subplot(2,3,3), plot(T./60, s/1000, 'r')
hold on
subplot(2,3,3), title('running diagram')
subplot(2,3,3), xlabel('time (min)')
subplot(2,3,3), ylabel('distance (km)')
%******************

subplot(2,3,4), plot(v*3.6,trac*inertial_mass)
hold on
subplot(2,3,4), plot(v*3.6,Res*inertial_mass, 'r')
subplot(2,3,4), plot(v*3.6, accel*inertial_mass, ' g')
subplot(2,3,4), title('specific traction, resistance and acceleration curve')
subplot(2,3,4), xlabel('velocity (km/h)')
subplot(2,3,4), ylabel('Tractive Effort (kN)')
subplot(2,3,4), legend('specific traction', 'resistance', 'acceleration')

%******************
subplot(2,3,5), plot(s/1000, acceler, 'b')
subplot(2,3,5), title('acceleration')
subplot(2,3,5), xlabel('distance (km)')
subplot(2,3,5), ylabel('acceleration (m/s^2)')

%******************
subplot(2,3,6), plot(s/1000, PowerF/1000000, 'b')
hold on
subplot(2,3,6), plot(s/1000, -PowerB/1000000, 'r')
subplot(2,3,6), title('Traction/Braking Power')
subplot(2,3,6), xlabel('distance (km)')
subplot(2,3,6), ylabel('power (MW)')
subplot(2,3,6), legend('Traction', 'Braking')
%******************


figure(2)
grid on
hold on
plot(s/1000, energy_consumed, 'k-');
 plot(s/1000, resistance_energy, 'b-.');
 plot(s/1000, kinetic_energy, 'r--');
 plot(s/1000, potential_energy, 'g');
 plot(s/1000, Traction_energy_pan, 'b');
 plot(s/1000, -Regen_energy_pan, 'm');
xlabel('distance (km)');
ylabel('energy (kWh)');
legend('net traction system energy', 'work done overcoming resistance', 'kinetic energy', 'potential energy', 'traction energy at pan', 'regen energy at pan')

figure(3)
grid on
hold on
 plot(s/1000, vel*3.6, 'r')
  %plot(s/1000, vel_limit*3.6, 'k')
 title('Velocity profile')
 xlabel('distance (km)')
ylabel('(km/h)')

%legend('Velocity', 'Velocity Limit')

%******************
% 
figure(4)
grid on
hold on
plot(s/1000, energy_consumed, 'k');
 plot(s/1000, resistance_energy, 'b-.');
 plot(s/1000, kinetic_energy, 'r--');
 plot(s/1000, potential_energy, 'g');
 plot(s/1000, energy_lost_traction, 'b');
 plot(s/1000, energy_lost_braking, 'm');
  plot(s/1000,energy_lost_braking_mech, 'm--');
 plot(s/1000, energy_audit, 'k--');
xlabel('distance (km)');
ylabel('energy (kWh)');
legend('work done by traction system', 'work done overcoming resistance', 'kinetic energy', 'potential energy', 'loss in traction', 'loss in elec braking', 'loss in mech braking','energy audit')

% 
% figure(4)
% plot(s/1000, PowerF/1000000, 'b')
% hold on
% plot(s/1000, PowerF_pan/1000000, 'b--')
% plot(s/1000, -PowerB/1000000, 'r')
% plot(s/1000, -PowerB_pan/1000000, 'r--')
% plot(s/1000, -PowerB_mech/1000000, 'k')
%  title('Traction/Braking Power')
%  xlabel('distance (km)')
%  ylabel('power (MW)')
%  legend('Traction at wheels','Traction at pan' ,'Braking at wheels', 'Braking at pan','Mechanical brake')
% %figure(2)
% %plot(s,accF, 'b.')
% %hold on 
% %plot(s,-accB, 'r.')
% %plot(s,acceleration, 'y')
% %plot(s,acceler, 'g.')
