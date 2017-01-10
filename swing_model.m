function dx = swing_model( t,x )
global robot

dx=zeros(14,1);

q=x(1:7);
dq=x(8:14);
q1=x(1); dq1=x(8);
q2=x(2); dq2=x(9);
q3=x(3); dq3=x(10);
q4=x(4); dq4=x(11);
q5=x(5); dq5=x(12);
q6=x(6); dq6=x(13);
q7=x(7); dq7=x(14);

yH=x(1);
zH=x(2);
qT=x(3);
q1R=x(4);
q2R=x(5);
q1L=x(6);
q2L=x(7);

[D,C,G,B,~]= robot.Dynamic_model(q,dq);

% u=zeros(4,1);
u=input_torque_IOL(x);
Fg=ground_force_swing(robot,x,u);
[ER,dER]=robot.get_ER(x);

% M=[D ER'; ER zeros(2,2)];
% temp=M^-1*(-[C*dq+G;dER*dq]+[B;zeros(2,4)]*u);
% Fg=-temp(8:9);

dx(1:7)=x(8:14);
dx(8:14)=D^-1*(-C*x(8:14)-G+B*u+ER'*Fg);
end



