%reset workspace
clear all; 
close all; 
clc;
tic;

%set screen parameters
x = -150e-6:1e-6:150e-6;                                                   %sampling rate
dx = x(2)-x(1);                                                            %unit sampling
y = x;                                                                      
[X Y] = meshgrid(x,y);
a = zeros(length(x));
U = sqrt(X.^2 + Y.^2);
a(find(U<=1e-4)) = 1;

%plot of single hole 
figure;
imagesc(a)

Z = repmat(a,3,3);                                                         %form hole array

%plot of hole array
figure;
imagesc(Z)      

D = padarray(Z,[1806 1806],0,'both');                                      %pad aperture

L = length(D)*dx;                                                          %length of aperture

%plot aperture
figure;
imagesc(D) 

%perform FFT calculation
fourier = fftshift((fft2(D)));                                             %fraunhofer diffraction

%freq coordinates
fx = -1/(2*dx):1/L:1/(2*dx)-1/L;

%spatial coordinates
x_obs = (632.8e-9*0.38).*fx;
dx_obs = x_obs(2) - x_obs(1);

%plot intensity
figure;
I = (abs(fourier)).^2;                                                     %Intensity
imagesc(x_obs,x_obs,I)


xlim([-2e-3 2e-3]);                                                        %set x limits   
xlabel('x [m]');
ylim([-2e-3 2e-3]);                                                        %set y limits
ylabel('y [m]');

toc;