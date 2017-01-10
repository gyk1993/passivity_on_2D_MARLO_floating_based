function Fg = ground_force_swing( robot,x,u )
            q=x(1:7);
            dq=x(8:14);
[ER,dER]=robot.get_ER(x);
[D,C,G,B,~]= robot.Dynamic_model(x(1:7),x(8:14));
Fg=(ER*D^-1*ER')^-1*(-dER*dq+ER*D^-1*(C*dq+G-B*u));

end