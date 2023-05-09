momentofinertia;

mdl = "sim_project";
open_system(mdl);
sim(mdl);

for i=1:N_max
    N = i;
    K_gain = K_dat(N);
    Is_sim = Is(N);
    sim(mdl);
end
