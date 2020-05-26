close all
clear all
clc
global Q Ps nu

Q=0.63;
Ps=0.008;
tspan=0:0.001:15000; %runtime of 10s, 0.001 s timestep
x_in=[0.1;0.1;0;0;0.1;0.1;0;0];

tic 
[t,x]=ode45('Herzel_fn_Feb19_asymmetric2_vocalis',tspan,x_in);
toc

maxima=findpeaks(x(end-13000000:end,5));
max_maxima=max(maxima);

for i=1:length(maxima)
    scatter(maxima(i),max_maxima,3*pi,'k','filled')
    hold on
end



[df,xi,bw1]=ksdensity(maxima,'Bandwidth',0.00004);  %Bandwidth specified
figure
plot(xi,df)
figure
[bw2,df2,xmesh]=kde(maxima);                       %Solve-the-equation-bandwidth
plot(xmesh,df2)