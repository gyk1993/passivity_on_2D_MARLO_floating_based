function u= input_torque_IOL( x )
global robot
global alpha
global theta_begin theta_end
global Kd Kp
q=x(1:7);
dq=x(8:14);
dhdq=get_dhdq(q,dq,alpha,theta_begin,theta_end);
dq_dhdqqdot=get_dq_dhdqqdot(q,dq,alpha,theta_begin,theta_end);
[h dh] = h_and_dh( x );

[D,C,G,B,~]= robot.Dynamic_model(q,dq);
[ER,dER]=robot.get_ER(x);
M=[D -ER'; ER zeros(2,2)];
H=[C*dq+G;dER*dq];
temp=dhdq*[eye(7) zeros(7,2)]*M^-1;

ddh=-Kd*dh-Kp*h;
% ddh=0;

u=(temp*[B;zeros(2,4)])^-1*(temp*H-dq_dhdqqdot*dq+ddh);

end

