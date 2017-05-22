function [ phi,psi,dC_CA,dN_CA,dN_C,dP_plane,ang_N_CA_C] = calcDihedrals(prevCO,currN,currCA,currCO,nextN,resSeq,logfileID,cutoff)
% phi and psi angles for an individual residue.
    if nargin == 7
        cutoff=6.5;
    end
    
    % Set CA coordinates to origin
    B = currN - currCA;
    C = currCO - currCA;    
    E = currN - currCO;
    F = prevCO - currN;
    
    % mainchain distances C-CA N-CA N-C and peptid plane distance
    dC_CA= norm(C);
    dN_CA= norm(B);
    dN_C = norm(E);
    dP_plane= norm(F);
    
    % angle N-CA-C
    ang_N_CA_C=findAngle(C,B);
 
    
    phi=calcDihedral(prevCO,currN,currCA,currCO,resSeq,logfileID,cutoff);
    
    psi=calcDihedral(currN,currCA,currCO,nextN,resSeq,logfileID,cutoff);
    
end

