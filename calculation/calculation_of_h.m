M=10;
N=4;
alpha=sym('alpha',[N,M+1],'real');
q=sym('q',[7,1],'real');
dq=sym('dq',[7,1],'real');
syms theta_begin theta_end real

H0=[0, 0, 0, .5, .5,  0,  0;...
    0, 0, 0,  0,  0, .5, .5;...
    0, 0. 0, -1,  1,  0,  0;...
    0, 0, 0.  0.  0. -1,  1];
c =[0, 0, -1, -.5, -.5, 0, 0];

h0=H0*q;
theta=c*q;
s=(theta-theta_begin)/(theta_end-theta_begin);
hd=sym(zeros(4,1));
for i=1:N
    hd(i)=0;
    for k=0:M
        hd(i)= hd(i) + alpha(i,k+1) * (factorial(M)/(factorial(k)*factorial(M-k))) * s^k * (1-s)^(M-k);
    end
end

h=h0-hd;

dhdq=jacobian(h,q);
dq_dhdqqdot=jacobian(dhdq*dq,q);


matlabFunction(dq_dhdqqdot, 'file', ['get_dq_dhdqqdot.m'], 'vars', {q,dq,alpha,theta_begin,theta_end});
matlabFunction(dhdq, 'file', ['get_dhdq.m'], 'vars', {q,dq,alpha,theta_begin,theta_end});