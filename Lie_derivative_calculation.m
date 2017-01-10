addpath('./dynamic_equations')

M=9;
x=sym('x',[14,1],'real');
alpha=sym('alpha',[4,M+1],'real');
syms theta_begin theta_end


H0=[0, 0, 0, .5, .5,  0,  0;...
    0, 0, 0,  0,  0, .5, .5;...
    0, 0. 0, -1,  1,  0,  0;...
    0, 0, 0.  0.  0. -1,  1];
c =[0, 0, -1, -.5, -.5, 0, 0];

h0=H0*x(1:7);

theta=c*x(1:7);
s=(theta-theta_begin)/(theta_end-theta_begin);

hd=sym(zeros(4,1));

for i=1:4
    for j=1:M+1
        hd(i)=hd(i)+alpha(i,j)*factorial(M)/(factorial(j-1)*factorial(M-j+1))*s^(j-1)*(1-s)^(M-j+1);
    end
end

h=h0-hd;

[D,C,G,~,B] = LagrangeModelAtrias2D(x(1:7),x(8:14));
D_inv=D^-1;
% D_inv=simplify(D_inv);
f=sym(zeros(14,1));
f(1:7)=x(8:14);
f(8:14)=D_inv*(-C*x(8:14)-G);

g=sym(zeros(14,4));
g(8:14,1:4)=D_inv*B;
% f=simplify(f);
% g=simplify(g);

Lfh=jacobian(h,x)*f;
Lgh=jacobian(h,x)*g;
LfLfh=jacobian(Lfh,x)*f;
LgLfh=jacobian(Lfh,x)*g;
% Lfh=simplify(Lfh);
% LfLfh=simplify(LfLfh);
% LgLfh=simplify(LgLfh);

% stringpoints=['Lfh  ';'Lgh  ';'LfLfh';'LgLfh'];
% pointscellarray=cellstr(stringpoints);
% matlabFunction(Lfh, 'file', ['cal_Lfh'], 'vars', {x,alpha});
% matlabFunction(Lfh,Lgh,LfLfh,LgLfh, 'file', ['cal_Lfh'], 'vars', {x,alpha,theta_end,theta_begin},'outputs',pointscellarray);
