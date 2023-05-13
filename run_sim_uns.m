momentofinertia;
Td_sim = 0.1;
mdl = "sim_project_coup";
open_system(mdl);
ublk_x = strcat(mdl,"/Uncertain Quadrotor 2D Dynamics X");
ublk_y = strcat(mdl,"/Uncertain Quadrotor 2D Dynamics Y");
ublk_z = strcat(mdl,"/Uncertain Quadrotor 2D Dynamics Z");

cross_blk_x = strcat(mdl,"/Cross-Moments/CrossX");
cross_blk_y = strcat(mdl,"/Cross-Moments/CrossY");
cross_blk_z = strcat(mdl,"/Cross-Moments/CrossZ");

delay_blk = strcat(mdl,"/Motors/Wifi Delay");
% delay_blk1 = strcat(mdl,"/Motors/Wifi Delay1");
% delay_blk2 = strcat(mdl,"/Motors/Wifi Delay2");
% delay_blk3 = strcat(mdl,"/Motors/Wifi Delay3");

set_param(ublk_x,"UValue","[]");
set_param(ublk_y,"UValue","[]");
set_param(ublk_z,"UValue","[]");

set_param(cross_blk_x,"UValue","[]");
set_param(cross_blk_y,"UValue","[]");
set_param(cross_blk_z,"UValue","[]");

set_param(delay_blk,"UValue","[]");
% set_param(delay_blk1,"UValue","[]");
% set_param(delay_blk2,"UValue","[]");
% set_param(delay_blk3,"UValue","[]");

Ixx= ureal('Ixx',Is_sim,'Percentage',30);
Iyy= ureal('Iyy',Is_sim,'Percentage',30);
Izz= ureal('Izz',Is_sim_z,'Percentage',30);

Td= ureal('Td',0.1,'Percentage',100);

s = tf('s');
a = 0.5; b = 1/12;
%delay_sys = (1-a*Td*s+b*(Td*s)^2)/(1+a*Td*s+b*(Td*s)^2);
delay = tf([b*Td^2,-a*Td,1],[b*Td^2,a*Td,1]);
%delay = exp(-Td*s);
delay_sys = [delay 0 0; 0 delay 0; 0 0 delay];

usys_x = tf(1,[Ixx 0]);
usys_y = tf(1,[Iyy 0]);
usys_z = tf(1,[Izz 0]);

cross_x = tf(Ixx-Izz,1);
cross_y = tf(Izz-Iyy,1);
cross_z = tf(Iyy-Ixx,1);
uvars = ufind(mdl);

samples = usample(uvars);


set_param(ublk_x,"UValue","samples");
set_param(ublk_y,"UValue","samples");
set_param(ublk_z,"UValue","samples");

set_param(cross_blk_x,"UValue","samples");
set_param(cross_blk_y,"UValue","samples");
set_param(cross_blk_z,"UValue","samples");

set_param(delay_blk,"UValue","samples");
% set_param(delay_blk1,"UValue","samples");
% set_param(delay_blk2,"UValue","samples");
% set_param(delay_blk3,"UValue","samples");
samples
Td_sim = samples.Td;
sim(mdl);

for i=1:24
    samples = usample(uvars);
    Td_sim = samples.Td
    samples
    sim(mdl);
end
