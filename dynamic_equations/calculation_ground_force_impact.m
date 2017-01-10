addpath('../dynamic_equations')

q=sym('q',[7,1],'real');
dq=sym('dq',[7,1],'real');
u=sym('u',[4,1],'real');
ddq=sym('ddq',[7,1],'real');
F=sym('F',[2,1],'real');



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

v_stance=ER*dq;
jacobian(v_stance,q)
