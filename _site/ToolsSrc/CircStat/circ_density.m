function lambda  = circ_density( phi_i,psi_i, kappa1,kappa2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

alfa=0.5;
 n_ang=10;
n_ang=length(phi_i);
lambda=zeros(n_ang,1);

for j=1:n_ang
    prod=1;
    for i=1:n_ang
        if prod>1e-5
            prod=prod * circ_vmpdffun(phi_i(i),psi_i(i),phi_i,psi_i,kappa1,kappa2);
        else
            break
        end
    end
    lambda(j,1) =(prod^(1/n_ang)/circ_vmpdffun(phi_i(j),psi_i(j),phi_i,psi_i,kappa1,kappa2))^alfa;
end
end

