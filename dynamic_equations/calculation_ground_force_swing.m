addpath('../dynamic_equations')

q=sym('q',[7,1],'real');
dq=sym('dq',[7,1],'real');
u=sym('u',[4,1],'real');
ddq=sym('ddq',[7,1],'real');
F=sym('F',[2,1],'real');

% q=[q1;q2;q3;q4;q5;q6;q7];
% dq=[dq1;dq2;dq3;dq4;dq5;dq6;dq7];
% u=[u1;u2;u3;u4];

% [D,C,G,~,B] = LagrangeModelAtrias2D(q,dq);


qT=q(3);
q1R=q(4);
q2R=q(5);
q1L=q(6);
q2L=q(7);

ER=[                                   1,                                   0
                                   0,                                   1
 - cos(q1R + qT)/2 - cos(q2R + qT)/2, - sin(q1R + qT)/2 - sin(q2R + qT)/2
                    -cos(q1R + qT)/2,                    -sin(q1R + qT)/2
                    -cos(q2R + qT)/2,                    -sin(q2R + qT)/2
                                   0,                                   0
                                   0,                                   0];
 ER=ER';

% ddq=D^-1*(B*u+C*dq-G+ER*F);                               
% [s_F]=solve(ER'*ddq==zeros(2,1),F); 

v_stance=ER*dq;
jacobian(v_stance,q)
% temp=[dq4*((dq3*sin(q3 + q4))/2 + (dq4*sin(q3 + q4))/2) + dq5*((dq3*sin(q3 + q5))/2 + (dq5*sin(q3 + q5))/2) + dq3*(dq3*(sin(q3 + q4)/2 + sin(q3 + q5)/2) + (dq4*sin(q3 + q4))/2 + (dq5*sin(q3 + q5))/2)
%  - dq3*(dq3*(cos(q3 + q4)/2 + cos(q3 + q5)/2) + (dq4*cos(q3 + q4))/2 + (dq5*cos(q3 + q5))/2) - dq4*((dq3*cos(q3 + q4))/2 + (dq4*cos(q3 + q4))/2) - dq5*((dq3*cos(q3 + q5))/2 + (dq5*cos(q3 + q5))/2)];


% temp2=jacobian(v_stance,q);
% temp2=[ 0, 0,   dq3*(sin(q3 + q4)/2 + sin(q3 + q5)/2) + (dq4*sin(q3 + q4))/2 + (dq5*sin(q3 + q5))/2,   (dq3*sin(q3 + q4))/2 + (dq4*sin(q3 + q4))/2,   (dq3*sin(q3 + q5))/2 + (dq5*sin(q3 + q5))/2, 0, 0
%  0, 0, - dq3*(cos(q3 + q4)/2 + cos(q3 + q5)/2) - (dq4*cos(q3 + q4))/2 - (dq5*cos(q3 + q5))/2, - (dq3*cos(q3 + q4))/2 - (dq4*cos(q3 + q4))/2, - (dq3*cos(q3 + q5))/2 - (dq5*cos(q3 + q5))/2, 0, 0];
