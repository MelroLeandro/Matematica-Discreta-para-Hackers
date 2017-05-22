function tor = Rotamer( PDBstruct,logfileID)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% Atoms for each side-chain angle for each residue
CHIS.ARG.chis1 = {'N';'CA';'CB';'CG' };
CHIS.ARG.chis2 = {'CA';'CB';'CG';'CD'};
CHIS.ARG.chis3 = {'CB';'CG';'CD';'NE'};
CHIS.ARG.chis4 = {'CG';'CD';'NE';'CZ'};
 
CHIS.ASN.chis1 = {'N';'CA';'CB';'CG' };
CHIS.ASN.chis2 = {'CA';'CB';'CG';'OD1'}; % Changed
 
CHIS.ASP.chis1 = {'N';'CA';'CB';'CG'};
CHIS.ASP.chis2 = {'CA';'CB';'CG';'OD1'};

CHIS.CYS.chis1 = {'N';'CA';'CB';'SG'};
 
CHIS.GLN.chis1 = {'N';'CA';'CB';'CG'};
CHIS.GLN.chis2 = {'CA';'CB';'CG';'CD' };
CHIS.GLN.chis3 = {'CB';'CG';'CD';'OE1'};
 
CHIS.GLU.chis1 = {'N';'CA';'CB';'CG' };
CHIS.GLU.chis2 = {'CA';'CB';'CG';'CD' };
CHIS.GLU.chis3 = {'CB';'CG';'CD';'OE1'};
 
CHIS.HIS.chis1 = {'N';'CA';'CB';'CG' };
CHIS.HIS.chis2 = {'CA';'CB';'CG';'ND1'};
 
CHIS.ILE.chis1 = {'N';'CA';'CB';'CG1' };
CHIS.ILE.chis2 = {'CA';'CB';'CG1';'CD1' };
 
CHIS.LEU.chis1 = {'N';'CA';'CB';'CG' };
CHIS.LEU.chis2 = {'CA';'CB';'CG';'CD1'};
 
CHIS.LYS.chis1 = {'N';'CA';'CB';'CG' };
CHIS.LYS.chis2 = {'CA';'CB';'CG';'CD' };
CHIS.LYS.chis3 = {'CB';'CG';'CD';'CE'};
CHIS.LYS.chis4 = {'CG';'CD';'CE';'NZ'};
 
CHIS.MET.chis1 = {'N';'CA';'CB';'CG' };
CHIS.MET.chis2 = {'CA';'CB';'CG';'SD' };
CHIS.MET.chis3 = {'CB';'CG';'SD';'CE'};
 
CHIS.PHE.chis1 = {'N';'CA';'CB';'CG' };
CHIS.PHE.chis2 = {'CA';'CB';'CG';'CD1'};
 
CHIS.PRO.chis1 = {'N';'CA';'CB';'CG' };
CHIS.PRO.chis2 = {'CA';'CB';'CG';'CD' };
 
CHIS.SER.chis1 = {'N';'CA';'CB';'OG' };
 
CHIS.THR.chis1 = {'N';'CA';'CB';'OG1' };
 
CHIS.TRP.chis1 = {'N';'CA';'CB';'CG' };
CHIS.TRP.chis2 = {'CA';'CB';'CG';'CD1'};
 
CHIS.TYR.chis1 = {'N';'CA';'CB';'CG' };
CHIS.TYR.chis2 = {'CA';'CB';'CG';'CD1' };
 
CHIS.VAL.chis1 = {'N';'CA';'CB';'CG1' };

current_residue = nan;

residue_list=[];
tor={};
%%
% Load N C and CA coordenates
%
for model = 1:length(PDBstruct.Model)
 
    for atom = PDBstruct.Model(model).Atom
        if current_residue~=atom.resSeq
            resSeq=atom.resSeq;
            if not(isnan(current_residue))
                CHList=nan*ones(1,4);
                if not(strcmp(amino.resName,'GLY') || strcmp(amino.resName,'ALA'))
                    CH=CHIS.(amino.resName);
                    List  = fieldnames(CH);
                    try
                        for chi = 1:length(List)
                            ListAtoms=CH.(List{chi});
                            for i = 1:length(ListAtoms)
                                name=ListAtoms{i};
                                AtomsXYZ(:,i)=amino.(name);
                            end
                            phi = calcDihedral(AtomsXYZ(:,1),AtomsXYZ(:,2),AtomsXYZ(:,3),AtomsXYZ(:,4),resSeq,logfileID,6.5);
                            CHList(chi)= phi;
                        end
                    catch
                        CHList=nan*ones(1,4);
                    end
                end
                amino.Rotamers=CHList;
                tor=[tor {amino}];
            end
            residue_list=[residue_list; atom.resName ];
            current_residue=atom.resSeq;
            %
            % New Amino

            amino=[];
            amino.resName = atom.resName;
            amino.chainID = atom.chainID;
            amino.resSeq = atom.resSeq;
            amino.tempFactor= atom.tempFactor;
            amino.model=model;
        end
        amino.(atom.AtomName)=[atom.X;atom.Y;atom.Z];
        amino.tempFactor= max(amino.tempFactor, atom.tempFactor);
    end
end
tor=[tor {amino}];

end

