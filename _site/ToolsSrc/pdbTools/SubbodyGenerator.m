function out = SubbodyGenerator( res,amino )
% Generation of subbodys, one for each amino
global SubBody;

%% Rigid bodies
%

Lbodies=SubBody.(amino).bodies;

numBodies=length(Lbodies);

out.main=res;
out.resName=amino;


for idxBodies=1:numBodies
    name=Lbodies{idxBodies};
           
    out.body.(name).force= {'quantum'};        % Force acting in the body
    out.body.(name).point=SubBody.(amino).(name);
    out.body.(name).vector=SubBody.TRP.Axis;
end

%% Constrains
%
contjoints=1;

LAxis=SubBody.(amino).Axis;
numAxis=length(LAxis);

% Revolute joint
for idxAxis=1:numAxis
        p1= LAxis{idxAxis}{1};
        p2= LAxis{idxAxis}{2};
        name=['J' int2str(contjoints)];
        out.Const.(name).class='Rev';
        out.Const.(name).Ci=p1;
        out.Const.(name).Cj=p2;
        out.Const.(name).Pi=p2;
        out.Const.(name).Pj=p2;
        out.Const.(name).si=[ p1 '_' p2];
        out.Const.(name).sj=[ p2 '_' p1];     
        contjoints=contjoints+1;   
end

% Fixed bodies
Lfixpbodies=SubBody.(amino).fixe;
numfixedbodes=length(Lfixpbodies);

for idx=1:numfixedbodes % 
        name=['J' int2str(contjoints)];
        out.Const.(name).class='Fix'; 
        out.Const.(name).Ci=Lfixpbodies{idx};
        contjoints=contjoints+1;
end


end

