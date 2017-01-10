function [ output_args ] = plot_robot( x )
L1=0.45; %m
L2=0.5;
L3=0.5;
L4=0.5;
LT=0.8; %m

yH=x(1);
zH=x(2);
qT=x(3);
q1R=x(4);
q2R=x(5);
q1L=x(6);
q2L=x(7);

th1R=qT+q1R;
th2R=qT+q2R;
th1L=qT+q1L;
th2L=qT+q2L;

pHip=[yH;zH];

R=@(x)[cos(x),-sin(x);sin(x),cos(x)];
p1R=pHip+R(th1R)*[0;L1];
p2R=pHip+R(th2R)*[0;L2];
p3R=p1R+R(th2R)*[0;L3];
p4R=p2R+R(th1R)*[0;L4];
PmR=p2R+R(th1R)*[0;L1];

p1L=pHip+R(th1L)*[0;L1];
p2L=pHip+R(th2L)*[0;L2];
p3L=p1L+R(th2L)*[0;L3];
p4L=p2L+R(th1L)*[0;L4];
PmL=p2L+R(th1L)*[0;L1];

pT=pHip+R(qT)*[0;LT];

plot([PmR(1),p1R(1),pHip(1),p2R(1),p4R(1)],[PmR(2),p1R(2),pHip(2),p2R(2),p4R(2)],'r')
hold on
plot([PmL(1),p1L(1),pHip(1),p2L(1),p4L(1)],[PmL(2),p1L(2),pHip(2),p2L(2),p4L(2)],'b')
plot([pT(1),pHip(1)],[pT(2),pHip(2)],'k');
hold off
end

