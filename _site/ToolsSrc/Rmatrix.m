function B = Rmatrix( A )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 [l c]=size(A);
 B=zeros(l,c);
 for i=1:l
     for j=1:c
         B(l-i+1,j) = A(i,j);
     end
 end
end

