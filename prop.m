%proportional

        vel_error(1,i)=kd*(vel_limit(1,i) - velF(1,i));
        
    
    if vel_error(1,i)>1
        vel_error(1,i)=1;
    end
    if vel_error(1,i)<=0
        vel_error(1,i)=0.1;
    end
%     if i>15000
%           vel_error(1,i)=0.005;
%     end