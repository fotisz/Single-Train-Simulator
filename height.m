%integral of the gradient profile:
grad_1=zeros(1, Size);
pos=2;
for i=1:fix(1000/del_S*max(gradient(:,1)))
   grad_1(1,i)=-gradient(pos-1,2);
    if i*del_S>=fix(gradient(pos,1)*1000)
        pos=pos+1;
    end
end
altitude = -cumtrapz(s(1,:), grad_1(1,:))/1000;
% plot(s/1000,altitude, 'k')
% xlabel('distance (km)')
% ylabel('altitude (m)')
