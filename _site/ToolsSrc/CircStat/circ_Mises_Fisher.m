function [p N_ang] = circ_Mises_Fisher(N_ang, phi_i,psi_i, kappa1,density)

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
if nargin < 5
    dim = 1;
else
    dim = 2;
end

delta = 2*pi/N_ang;

p=zeros(N_ang,N_ang);

phi=-pi+delta/2;
psi=-pi+delta/2;
N_data=length(phi_i);

if dim==2
    C = 1./(N_data.*besseli(0,kappa1./density));
else
    C = 1/(N_data*besseli(0,kappa1));
end

for i=1:N_ang
    psi=-pi+delta/2;
    for j=1:N_ang
        sum=0;
        x=[cos(psi);sin(phi)];
        for k=1:N_data
                x_i=[cos(psi_i(k));sin(phi_i(k))];
                if dim==2
                   sum=sum + C(i,j)*exp(kappa1/density(i,j)*x'*x_i);
                else
                   sum=sum + C*exp(kappa1*x'*x_i);
                end
                    
        end
        p(i,j) = sum;
        
        psi=psi+delta;
    end
    phi=phi+delta;
end
