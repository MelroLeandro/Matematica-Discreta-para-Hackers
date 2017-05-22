function [p N_ang] = circ_hist(N_ang, phi_i,psi_i)

% [p alpha] = circ_vmpdf2(phi, psi, data, kappa)
%   Density etimetion using the von Mises pdf in two
%   dimensions for Ramachandar data
%
%   The vmpdf is given by f(phi) =
%   (1/(4pi^2*N_i*I0(kappa)^2)*sum_i(exp(kappa*cos(phi-phi_i)+cos(psi-psi_i))
%
%   Input:
%     N_ang            number of partitions for [0,2pi],
%     phi_i, psi_i     angles from a dataser,
%     kappa            concentration parameters, default is 1
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

p=zeros(N_ang,N_ang);

phi=-pi+delta/2;
psi=-pi+delta/2;
N_data=length(phi_i);

for i=1:N_ang
    psi=-pi+delta/2;
    for j=1:N_ang
        sum=0;
            for k=1:N_data
                if abs(phi-phi_i(k))/delta < 1
                    ADD1=.5;
                else
                    ADD1=.0;
                end
                if abs(psi-psi_i(k))/delta < 1
                    ADD2=.5;
                else
                    ADD2=.0;
                end
                sum=sum + ADD1*ADD2;
            end
            p(i,j) = 1/(N_data*delta) * sum;
        
        psi=psi+delta;
    end
    phi=phi+delta;
end
