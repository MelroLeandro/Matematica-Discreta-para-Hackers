
binAng = 180;

%aminos={'PHE'; 'ASP'; 'THR'; 'ARG'; 'TRP'; 'VAL'; 'CYS'; 'SER'; 'ALA'; 'GLY'; 'MET'; 'TYR'; 'ASN'; 'PRO'; 'LYS'; 'HIS'; 'GLN'; 'ILE'; 'LEU'; 'GLU'};
aminos={'ARG'}

for i=1:length(aminos)   
    res=aminos{i};
    aminoCont = ForcesCont(res,binAng);
end