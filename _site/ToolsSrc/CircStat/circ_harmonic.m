function [p N_ang] = circ_harmonic(N_ang, phi_i,psi_i)

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
if nargin < 6
    dim = 1;
else
    dim = 2;
end

delta = 2*pi/N_ang;

p=zeros(N_ang,N_ang);

phi=-pi+delta/2;
psi=-pi+delta/2;
N_data=length(phi_i);

for i=1:N_ang
    for j=1:N_ang
        sum=0;
            for k=1:N_data
                if (phi-phi_i(k))^2>1e-15&& (psi-psi_i(k))>1e-15
                    sum = sum + log(1/sqrt((cos(phi-phi_i(k))-cos(psi-psi_i(k)))^2+(sin(phi-phi_i(k))-sin(psi-psi_i(k)))^2));
                end
            end
        p(i,j) = 1/(2*pi) * sum;
        psi=psi+delta;
    end
    phi=phi+delta;
end


