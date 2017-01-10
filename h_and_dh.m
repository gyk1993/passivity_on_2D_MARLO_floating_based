function [h dh] = h_and_dh( x )
global alpha
global theta_begin theta_end

hd=zeros(4,1);
dhd=zeros(4,1);
H0=[0, 0, 0, .5, .5,  0,  0;...
    0, 0, 0,  0,  0, .5, .5;...
    0, 0. 0, -1,  1,  0,  0;...
    0, 0, 0.  0.  0. -1,  1];
c =[0, 0, -1, -.5, -.5, 0, 0];
h0=H0*x(1:7);
dh0=H0*x(8:14);

theta=c*x(1:7);
s=(theta-theta_begin)/(theta_end-theta_begin);

for i=1:4
    hd(i)=bc_curve(s,alpha(i,:));
    dhdds(i)=bc_curve_ds(s,alpha(i,:));
    dhd(i)=dhdds(i)/(theta_end-theta_begin)*c*x(8:14);
end
h=h0-hd;
dh=dh0-dhd;
end

