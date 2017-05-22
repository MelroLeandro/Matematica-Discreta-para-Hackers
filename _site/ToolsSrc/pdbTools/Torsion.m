function tor = Torsion( PDBstruct, logfileID )
% Calculate the backbone angles for a pdb structur

%   Detailed explanation goes here

model_list=[];
chain_list=[];
residue_list=[];
Bfactor_list=[];
resSeq_list=[];
N=[];
CO=[];
CA=[];

current_residue = nan;
%%
% Load N C and CA coordenates
%
for model = 1:length(PDBstruct.Model)
    
    for atom = PDBstruct.Model(model).Atom

        if current_residue~=atom.resSeq
            model_list=[model_list model];
            residue_list=[residue_list; atom.resName];
            Bfactor_list=[Bfactor_list; atom.tempFactor];
            chain_list=[chain_list ; atom.chainID];
            resSeq_list=[resSeq_list ; atom.resSeq];
            current_residue=atom.resSeq;
            %fprintf('Res %s\n', atom.resName);
        else
            Bfactor_list(end)=max(Bfactor_list(end),atom.tempFactor);
        end

        if strcmp(atom.AtomName,'N')
            N=[N [atom.X;atom.Y;atom.Z]];
        elseif strcmp(atom.AtomName,'CA')
            CA=[CA [atom.X;atom.Y;atom.Z]];
        elseif strcmp(atom.AtomName,'C')
            CO=[CO [atom.X;atom.Y;atom.Z]];
        end
    end
end

%%
% Calculate phi and psh for each residue.
%
tor=[];

current_chain='';
current_model=nan;

num=length(residue_list);

for i = 1:num
  if i > 1 && i <num && current_model==model_list(i) && strcmp(current_chain,chain_list(i))
       [ phi,psi,dC_CA,dN_CA,dN_C,dP_plane, ang_N_CA_C]=calcDihedrals(CO(:,i-1),N(:,i),CA(:,i),CO(:,i),N(:,i+1),resSeq_list(i),logfileID);
       ang  = calcDihedral(CA(:,i-1),CO(:,i-1),N(:,i),CA(:,i),resSeq_list(i),logfileID,6.5);
       amino.chainID=chain_list(i,:);
       amino.resName=residue_list(i,:);
       amino.model=model_list(i);
       amino.resSeq=resSeq_list(i);
       amino.phi = phi; 
       amino.psi = psi;
       amino.omega = ang;
       amino.dC_CA = dC_CA; 
       amino.dN_CA = dN_CA; 
       amino.dN_C = dN_C; 
       amino.dP_plane = dP_plane;
       amino.ang_N_CA_C = ang_N_CA_C;
       amino.tempFactor = max([Bfactor_list(i-1) Bfactor_list(i) Bfactor_list(i+1)]);
       tor = [tor amino];
  else 
       amino.chainID=chain_list(i,:);
       amino.resName=residue_list(i,:);
       amino.model=model_list(i);
       amino.resSeq=resSeq_list(i);
       amino.phi = nan; 
       amino.psi = nan;
       amino.omega = nan;
       amino.dC_CA = nan; 
       amino.dN_CA = nan; 
       amino.dN_C = nan; 
       amino.dP_plane = nan;
       amino.ang_N_CA_C = nan;
       amino.tempFactor = nan;
       tor = [tor amino];
  end
  current_chain=chain_list(i);
  current_model=model_list(i);
end

end

