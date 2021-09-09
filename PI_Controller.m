%% Bode plot of PI controller

s = tf('s');

Kp = 0.7;%0.9
Ki = 100;%1218
Vin = 28;
Vc = 42;
D = 0.2857;%0.28
R = 20;
L = 33e-6;
Le = L/(1-D)^2;
C = 1.2e-3;
%Go = V/D;
r = 10.5e-3;
%wz = D^2*R/L;
%Q = D*R*sqrt(C/L);
%wo = D/sqrt(L*C);

%Gp1 = Go*(1-s/wz)/(1+s/(Q*wo)+(s/wo)^2);
Gp2 = Vin/(1-D)^2*(1-s*Le/R)*(1+s*r*C)/(Vc*Le*C*(s^2+s*(1/(R*C)+r/Le)+1/(Le*C)))
%Gp3 = -Vc/(1-D)*(L*s/(R*(1-D)^2)-1)/(L*C*s^2/(1-D)^2+L*s/(R*(1-D)^2)+1);
Gc1 = 1.045*(s+157)/s;
%Gc1 = 0.037*(s+2.87e3/1.5)/s;
%Gc2 = 30e-6*(s-10e-5)/s;
%G1 = Gc1*Gp2/(1+Gp2*Gc1);
G2_WOC = Gp2/(1+Gp2);
G2_WC = Gc1*Gp2/(1+Gp2*Gc1);
G2_CE = Gp2*Gc1;

f1 = figure(1);
subplot(3,1,1);
rlocus(G2_CE);
subplot(3,1,2);
step(G2_WOC);
xlim([0 0.3])
subplot(3,1,3);
step(G2_WC);
xlim([0 0.3])
saveas(f1,'closed_system.png');
%subplot(3,1,2);
%rlocus(Gp3*Gc1);
f2 = figure(2);
%subplot(3,1,1);
margin(Gp2);
[Gm,Pm,Wcg,Wcp] = margin(Gp2);
saveas(f2,'boost_before.jpg');
%subplot(3,1,2);
%margin(Gc1);
%subplot(3,1,3);
%margin(G2_CE);
f3 = figure(3);
margin(G2_CE);
saveas(f3,'boost_after.jpg');
