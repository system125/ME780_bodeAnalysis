%% -- Initialization of the parameters
clear all;
% freq_array = [0.5 1.0 2.0 2.5 3.0 3.5 ...
%         4.0 4.5 5.0 8.0 12.00 16.0 20.0 30.0];

% ws = logspace(0,2,20);
% freq_array = ws/(2*pi);

freq_array = logspace(0,1.6,20);

Ts = 0.001;

t_start = 0;
t_end = 20;
t_dwell = 4;




%% -- Run test 

for i = 1:length(freq_array)
    f = freq_array(i);

    t = (t_start:Ts:t_end)';
    u_t = 2.0*sin(2*pi*f*t);
    u = timeseries(u_t,t);

    disp("Running the tests!!")
    t_ends = sprintf("%f",t_end);
    set_param("sineWaveGenerator",'StartTime','0','StopTime',t_ends);
    set_param("sineWaveGenerator","SimulationCommand","Start");
    pause(t_end + t_dwell)
    disp("Completed running test!!")

    % -- Save the simulation data to file
    t = v.time;
    
    fileName = sprintf("freq_data_%d.mat",i);
    data = [t u_t x.signals.values v.signals.values]';
    save(fileName,"data")
end
disp("Ended the simulations!!!")