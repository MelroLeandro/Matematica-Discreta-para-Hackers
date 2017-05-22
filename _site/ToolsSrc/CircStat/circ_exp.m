function [p N_ang total] = circ_exp(N_ang, phi_i,psi_i)

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

p=zeros(N_ang,N_ang);

phi=-pi+delta/2;
psi=-pi+delta/2;
N_data=length(phi_i);

D=@(x1,y1,x2,y2)sqrt(0.5*min(abs(x1-x2),2*pi-abs(x1-x2))^2+min(abs(y1-y2),2*pi-abs(y1-y2))^2);
%D=@(x1,y1,x2,y2)(x1-x2)^2+(y1-y2)^2;
var=5^2;

total=0;
for i=1:N_data
    for j=1:N_data
         total = total + exp(-D(phi_i(i),psi_i(i),phi_i(j),psi_i(j))/var);
    end
end
            
for i=1:N_ang
    psi=-pi+delta/2;
    for j=1:N_ang
        sum=0;
            for k=1:N_data
                    sum = sum + exp(-D(phi,psi,phi_i(k),psi_i(k))/var);
            end
        p(i,j) = sum/total;
        psi=psi+delta;
    end
    phi=phi+delta;
end


