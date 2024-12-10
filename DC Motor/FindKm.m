g = 9.81;
angle = 6.76;
R = 0.11127;

angle_rad = deg2rad(angle);  

current = semilab1{1}{1}.Values.Data;
loadcell_kg = semilab1{1}{4}.Values.Data;

I_rms = sqrt(mean(current.^2));

mean_kg = mean(loadcell_kg);

Force = (mean_kg * g) / cos(angle_rad);
torque = Force * R;

Km = torque / I_rms;

disp(I_rms);
disp(torque);
disp(Km);