function [p1 p2 N_ang ] = circ_d1exp(N_ang, phi_i,psi_i,total)

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

p1=zeros(N_ang,N_ang);
p2=zeros(N_ang,N_ang);

phi=-pi+delta/2;
psi=-pi+delta/2;
N_data=length(phi_i);

D=@(x1,y1,x2,y2)min(abs(x1-x2),2*pi-abs(x1-x2))^2+min(abs(y1-y2),2*pi-abs(y1-y2))^2;
%D=@(x1,y1,x2,y2)(x1-x2)^2+(y1-y2)^2;
var=16;

            
for i=1:N_ang
    psi=-pi+delta/2;
    for j=1:N_ang
        sum1=0;
        sum2=0;
            for k=1:N_data
                    if abs(phi-phi_i(k))<2*pi-abs(phi-phi_i(k))
                        A=2*abs(phi-phi_i(k))*sign(phi-phi_i(k))/var^2;
                    else
                        A=-2*abs(phi-phi_i(k))*sign(phi-phi_i(k))/var^2;
                    end
                    if abs(psi-psi_i(k))<2*pi-abs(psi-psi_i(k))
                        B=2*abs(psi-psi_i(k))*sign(psi-psi_i(k))/var^2;
                    else
                        B=-2*abs(psi-psi_i(k))*sign(psi-psi_i(k))/var^2;
                    end
                    sum1 = sum1 + exp(-D(phi,psi,phi_i(k),psi_i(k))/var^2)*A;
                    sum2 = sum2 + exp(-D(phi,psi,phi_i(k),psi_i(k))/var^2)*B;
            end
        p1(i,j) = sum1/total;
        p2(i,j) = sum2/total;
        psi=psi+delta;
    end
    phi=phi+delta;
end


