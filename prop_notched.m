%proportional and notched
%approximate time calculation
    del_T_F(1,i+1)=2*del_S/(velF(1,i)+velF(1,i+1));
    if velF(1,i)==0
        T_F(1,i+1)=T_F(1,i)+1;
    else
        T_F(1,i+1)=T_F(1,i)+del_T_F(1,i+1);
    end

    if T_F(1,i)>=counter
        vel_error(1,i)=kd*(vel_limit(1,i) - velF(1,i));
        if velF(1,i)>30
        counter=counter+30;
        else
        counter=counter+10;
        end
    else
        vel_error(1,i)=vel_error(1,i-1);
    end
    
    if vel_error(1,i)>1
        vel_error(1,i)=1;
    end
    vel_error(1,i)=round(vel_error(1,i)*notch_num)/notch_num;
    if vel_error(1,i)<=0
        vel_error(1,i)=0.01;
    end