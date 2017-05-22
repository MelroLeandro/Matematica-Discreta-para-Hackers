function [p N_ang] = circ_vmpdf2(N_ang, phi_i,psi_i, kappa1, kappa2, lambda)

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

deltaGrid=0.18;
N_Grid = round(2*pi/deltaGrid)+1;
grid=zeros(N_Grid);

for k=1:N_data
    i=round((phi_i(k)+pi)/deltaGrid)+1;
    j=round((psi_i(k)+pi)/deltaGrid)+1;
    grid(i,j)=grid(i,j)+1;
end


for i=1:N_ang
    for j=1:N_ang
        sum=0;
        if dim==2
            for k=1:N_data
                C = 1/(4*pi^2*N_data*besseli(0,kappa1/lambda(k))*besseli(0,kappa2/lambda(k)));
                sum=sum + C*exp(kappa1/lambda(k)*cos(phi-phi_i(k))+kappa2/lambda(k)*cos(psi-psi_i(k)));
            end
            p(i,j) = sum;
        else
            for k=1:N_data
                i=round((phi_i(k)+pi)/deltaGrid)+1;
                j=round((psi_i(k)+pi)/deltaGrid)+1;
                sum=sum + exp(kappa1*cos(phi-phi_i(k))+kappa1*cos(psi-psi_i(k)))*grid(i,j);
            end
            C = 1/(4*pi^2*N_data*besseli(0,kappa1)*besseli(0,kappa2));
            p(i,j) = C * sum;
        end
        
        psi=psi+delta;
    end
    phi=phi+delta;
end
end