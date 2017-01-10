close all
addpath('./dynamic_equations');
addpath('./plot_functions');
global robot
global Kd Kp
global alpha
global theta_begin theta_end

Kd=60*eye(4);
Kp=(Kd^2/5)*eye(4);


theta_begin=-3.28283938204512;
theta_end=-2.99861395834076;
alpha=[3.2684	3.2878	3.2354	3.2111	3.1820	3.0640	3.1421	2.9644	3.0291	2.9366	2.9843
2.9844	3.0219	3.0384	3.1055	3.1102	3.1988	3.2000	3.2654	3.2757	3.2984	3.2689
0.8946	0.8498	0.8948	0.8349	0.9447	0.8034	0.9500	0.8247	0.8975	0.8522	0.8938
0.8944	0.9253	0.9923	1.1657	1.0272	1.5720	1.0313	1.6578	1.2176	1.3796	0.8946];

robot=Marlo_2D_class;
% IC=[0;0;0.1+pi;0.6;1.2;-0.1;1.2;zeros(7,1)];
% IC(1:7)=world2gen(IC(1:7));
IC=[-0.126924003230113,0.892633478453995,0.0144401811397378-0.1,2.82107446958686-0.2,3.71572393222390,2.53718236308092,3.43161888788060,0.304209189041967,0.167495253863220,-0.605599205922010,0.529759827654585,-0.0389607154494542,0.279145622127161,0.670110217136690];
timespan=0:0.01:10;
opts = odeset('AbsTol',1e-12,'MaxStep',1e-2,'Events',@impactevent);
X=[];
T=[];
tstart=0;
for j=1:20
    [TT,XX]=ode45(@swing_model,timespan,IC,opts);
    IC=impact_model(XX(end,:)'); % leg switch is considered in the impact model
    X=[X;XX];
    T=[T;tstart+TT];
    tstart=tstart+TT(end);
%     impact_index=[impact_index; length(X)];
end


H0=[0, 0, 0, .5, .5,  0,  0;...
    0, 0, 0,  0,  0, .5, .5;...
    0, 0. 0, -1,  1,  0,  0;...
    0, 0, 0.  0.  0. -1,  1];
c =[0, 0, -1, -.5, -.5, 0, 0];
for i=1:length(T)
    theta=c*X(i,1:7)';
    s=(theta-theta_begin)/(theta_end-theta_begin);
    for j=1:4
        hd(j,i)=bc_curve(s,alpha(j,:));
    end
    h0(:,i)=H0*X(i,1:7)';
end

fig=figure(1);
clf(fig); 
color=['r','g','b','m'];
hold on
for j=1:4
    plot(T,hd(j,:),[color(j)]);
    plot(T,h0(j,:),[color(j),'--']);
end
hold off
figure
for i=1:length(T)
    plot_robot(X(i,:))
    hold on
    walk_range=-5:0.1:30;
    plot(walk_range,zeros(1,length(walk_range)),'LineWidth',2)
    hold off
    axis equal
    axis([-3+X(i,1) +3+X(i,1) -1 3])
    drawnow;
    pause(0.01);
end
