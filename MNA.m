clear 
close all
clc
%DC sweep
Vin = linspace(-10, 10,21);
% syms v(t) v1(t) v2(t) v3(t) v4(t) v5(t) v6(t) 
% V=[v; v1 ;v2 ;v3 ; v4 ;v5; v6];
% conduction matrix 
G = [1 0 0 0 0 0 0; 
    0 -1 1 0 0 0 0;
    1 -1.5 0 -1 0 0 0;
    0 0 -0.1 1 0 0 0;
    0 0 0 0 10 1 -10;
    0 0 -10 0 1 0 0;
    0 0 0 0 0 1 1/1000];
% capacitance matrix 
C = [0 0 0 0 0 0 0;
    0 0 0 0.2 0 0 0;
    0.25 -0.25 0 0 0 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0];

for l = 1:21
    % input vector 
F = [Vin(l); 0; 0; 0; 0; 0; 0];

% solve for voltage ignoring time dependent 
V = G\F

V0(l)=V(7);
V3(l)=V(3);
end
subplot(2,2,1)
plot (Vin, V0,Vin,V3)
xlabel('Vin (V)')
ylabel('Voltage ')
% frequency sweep 
freq =linspace (0,16,10000)*2*pi;
% set input vector to one volt at the source to make future calculations
% easy
F = [1; 0; 0; 0; 0; 0; 0];
for l = 1:size(freq, 2)
    % solve for the V vector 
   V =  (G+j*freq(l)*C)\F;
    
   V02(l)=20*log10(abs(V(7)));
   V32(l)=20*log10(abs(V(3)));
end 
subplot(2,2,2)
plot (freq, V02,freq,V32)
xlim([0 100])
xlabel('frequency (Rad/s)')
ylabel('gain (dB)')
% create a normaly distrobuted array of capacitor valuse 
cap = normrnd(0.25,0.05,[1,100000]);
subplot(2,2,3)
hist(cap)
xlabel('capacitance (f)')


for l = 1:size(cap, 2)
   % re crate the c matrix 
   C = [0 0 0 0 0 0 0;
    0 0 0 0.2 0 0 0;
    cap(l) -(cap(l)) 0 0 0 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0];
% solve for voltage 
    V =  (G+j*pi*C)\F;
    
    Vo (l)=abs(V(7));
    
end
subplot(2,2,4)
hist(Vo)
xlabel ('Vo/Vin')