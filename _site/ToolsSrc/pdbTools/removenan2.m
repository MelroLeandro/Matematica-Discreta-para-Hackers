function N = removenan2( L,Num)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    [Num,col] = size(L);
end 
N=[];
for i=1:Num
    x=L(i,:);
    if ~isnan(x(1)) && ~isnan(x(2)) && ~isnan(x(8))&& ~isnan(x(9)) 
        N=[N;x];
    end
end

end
