momentofinertia;

N = 3;
K_gain = K_dat(N);

mdl = "sim_project";
open_system(mdl);
ublk = strcat(mdl,"/Uncertain Quadrotor 2D Dynamics");
set_param(ublk,"UValue","[]");

Is_sim = ureal('Is_sim',Is(N),'Percentage',20);
usys = tf(1,[Is_sim 0]);
uvars = ufind(mdl);


set_param(ublk,"UValue","usample(uvars)");
sim(mdl);

for i=1:30
    sim(mdl);
end
