close all
clear all
clc

global Q Ps

Q=0.63;
Ps=0.008;
tspan=0:0.001:10000;

x1_in_range=-0.1:0.01:0.5;
x2_in_range=-0.1:0.01:0.5;

for i=1:length(x1_in_range)
    x1l_in=x1_in_range(i);
    x1r_in=x1_in_range(i);
    
    for j=1:length(x2_in_range)
        x2l_in=x2_in_range(j);
        x2r_in=x2_in_range(j);
        
        x_in=[x1l_in ;0.1 ;x2l_in ;0 ;x1r_in ; 0.1;x2r_in; 0];
        [t,x]=ode45('Herzel_fn_Feb19_asymmetric2_vocalis_nonlinear',tspan,x_in);
        
        loc_max=findpeaks(x(end-8000000:end,5));
        
        [df,xi]=ksdensity(maxima,'Bandwidth',0.00004); %apply Kernel Density estimation
        n_attract=length(findpeaks(df));       %No of peaks in density function of maxima
        
        if n_attract==1
            scatter(x1l_in,x2l_in,'b') %Bluepoint for 1-period LCO
            hold on
        elseif n_attract==2
            scatter(x1l_in,x2l_in,'g') %Greenpoint for 2-period LCO
            hold on
        elseif n_attract==3
            scatter(x1l_in,x2l_in,'y') %Yellow for 3-period LCO
            hold on
        elseif n_attract>3&&n_attract<8
            scatter(x1l_in,x2l_in,'m') %Magenta for multiperiod LCO
            hold on
        elseif n_attract>8
            scatter(x1l_in,x2l_in,'r') %Red for aperiodic signature (see if quasiperiodicity diff is possible)
            hold on
        end
       
       
    end
end
