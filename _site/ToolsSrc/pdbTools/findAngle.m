function [ ang ] = findAngle(u,v)
% Calculates the angle (degrees) between two vectors (as 1-d arrays) 
% using dot product.
    mag_u = norm(u);
    mag_v = norm(v);
    
    d=u'*v/(mag_u*mag_v);
    d=min(d,1);
    d=max(-1,d);
    %ang = 180/pi * acos(d);
    ang = acos(d);
end

