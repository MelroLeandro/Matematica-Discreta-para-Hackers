function [p N_ang] = circ_disc(N_ang, phi_i,psi_i)

% [p alpha] = circ_harmonic(phi, psi, data, kappa)
%   Density etimetion using the fundamental solution of laplace's equation
%
%   The vmpdf is given by f(phi) =
%   (1/(4pi^2*N_i*I0(kappa)^2)*sum_i(exp(kappa*cos(phi-phi_i)+cos(psi-psi_i))
%
%   Input:
%     N_ang            number of partitions for [0,2pi],
%     phi_i, psi_i     angles from a dataser,
%
%   Output:
%     p         von Mises pdf evaluated
%     alpha     angles at which pdf was evaluated
%
%
%   References:
%     Statistical analysis of circular data, Fisher
%
% Circular Statistics Toolbox for Matlab

% By CLeandro, 2014

% evaluate pdf

delta = 2*pi/N_ang;

p=zeros(N_ang+1,N_ang+1);

phi=-pi+delta/2;
psi=-pi+delta/2;
N_data=length(phi_i);

ang=2*pi/N_ang;

for k=1:N_data
    i=round((pi+psi_i(k))/ang)+1;
    j=round((pi+phi_i(k))/ang)+1;
    p(i,j)=p(i,j)+1;
end
p=(p+1)/N_data;


