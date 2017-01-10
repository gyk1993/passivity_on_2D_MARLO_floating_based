clear all
load('opt_result_concise_7.mat');
H0=[0, 0, 0, 0,0,0,0, .5, .5,  0,  0;...
    0, 0, 0, 0,0,0,0, 0,  0, .5, .5;...
    0, 0. 0, 0,0,0,0,-1,  1,  0,  0;...
    0, 0, 0. 0,0,0,0, 0.  0. -1,  1];
c =[0, 0, -1, -.5, -.5, 0, 0,0,0,0,0];
H=[H0;c];

h0=H0*q';
dh0=H0*dq';
ddh0=H0*ddq';
theta=c*q';
dtheta=c*dq';

M=5;
alpha=zeros(4,M+1);

alpha(:,1)=H0*q(1,:)';
alpha(:,end)=H0*q(end,:)';

alpha(:,2)=alpha(:,1)+(theta(end)-theta(1))/(M*dtheta(1))*H0*dq(1,:)';
alpha(:,end-1)=alpha(:,end)-(theta(end)-theta(1))/(M*dtheta(end))*H0*dq(end,:)';

[a,b,s]=bc_curve_symbolic(M);
a_str=arrayfun(@char,a,'UniformOutput', false);
p_a=a_str([1,2,end-1,end]);
c_a=a_str(3:end-2);
g=matlabFunction(b,'Vars',[ a(3:end-2) a([1,2,end-1,end]) s]);
% g=matlabFunction(b);
bcft=fittype(g,'independent','s','coefficients',c_a,'problem',p_a);

s=(theta-theta(1))/(theta(end)-theta(1));
for i=1:4
    result=fit(s',h0(i,:)',bcft,'problem',num2cell(alpha(i,[1,2,end-1,end])),'StartPoint',zeros(1,M-3));
    mid_index=3:M-1;
    alpha(i,mid_index)=coeffvalues(result);
end

theta_begin=c*q(1,:)';
theta_end=c*q(end,:)';

hd_fit=bc_curve(s,alpha(3,:))
plot(s,hd_fit)
hold on
plot(s,h0(3,:))
hold off

