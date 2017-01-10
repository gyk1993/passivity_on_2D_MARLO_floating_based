theta=-q(:,3)-1/2*(q(:,4)+q(:,5))+3/2*pi;
qRLA=1/2*(q(:,4)+q(:,5));
qLLA=1/2*(q(:,6)+q(:,7));
tspan=linspace(0,t(1),29);
plot(tspan,theta);
scatter(theta,qRLA);