function [ ang ] = calcDihedral(P1,P2,P3,P4,resSeq,logfileID,cutoff)
% phi and psi angles for an individual residue.
    if nargin==4
        cutoff=inf;
    end
    % Set CA coordinates to origin
    ab = P1 - P2;
    cb = P3 - P2;
    db = P4 - P3;
    
    % Make sure the atoms are close enough 
    if nargin> 4 && max([norm(ab),norm(cb),norm(db)]) > cutoff
        fprintf(logfileID,'\t\tAtoms too far apart to be bonded! at res:%d\n',resSeq);
        fprintf(logfileID,'\t\t\tab: %f cb:%f db:%f\n',norm(ab),norm(cb),norm(db));
        ang=nan;
    else
 
        % Calculate necessary cross products (define vectors normal to planes)
        u = cross(ab,cb);
        v = cross(db,cb);
        w = cross(u,v);

        % Determine scalar angle between normal vectors
        ang = findAngle(u,v);

        if findAngle(cb,w) > 0.001
            ang = -ang;
        end
    end
   
end

