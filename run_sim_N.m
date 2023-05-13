momentofinertia;

mdl = "sim_project_coup";
open_system(mdl);
sim(mdl);

for i=1:N_max
    N = i;
    K_gain = K_dat(N);
    Is_sim = Is(N);
    Ixx = Is_sim*1.2;
    Iyy = Is_sim*0.98;
    sim(mdl);
end
