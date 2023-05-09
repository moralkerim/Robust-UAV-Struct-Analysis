clear all;
clc;
Im = 2.8e-2;
m = 1.6;
h = 0.32;
Il_dat = zeros(1,10);
Is =  zeros(1,10);
K_dat = zeros(1,10);
K_dat(1,1) = 1;
Is(1,1) = Im;

N_sim = 1;
N_max = 20;

for N=2:N_max
    
d = h;
if(mod(N,2) == 0)
   dp = d/2;
   Il = dp^2;
   if(N/2 >= 2)
       for i=2:N/2
           Il = Il + ((i-1+(1/2))*d)^2;
       end
   end


else
    dp = d;
    Il = dp^2;
    if((N-1)/2 >= 2)
        for i=2:(N-1)/2
           Il = Il + ((i)*d)^2;
        end
    end
end

N;
Il = 2*m*Il;
Il_dat(1,N) = Il;
Is(1,N) = Il_dat(1,N) + N*Im;
K_gain = (N * Im + Il)/(N*Im);
K_dat(1,N) = K_gain;
end

K_gain = K_dat(N_sim);
N = N_sim;
Is_sim = Is(N);
