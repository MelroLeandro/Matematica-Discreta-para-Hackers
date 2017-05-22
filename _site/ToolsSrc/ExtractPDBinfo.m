single_pdb=0;

if single_pdb==1
     pdb_ids='1UAO';
else
    % Select protein list
    pdb_file_list='pdb1A.tsv';

    % Read protein list
    pdblistID = fopen(pdb_file_list,'r');
    pdb_ids = fscanf(pdblistID, '%s');
    fprintf('File reading----\n');
    
    fclose(pdblistID);
end

%%

logfileID = fopen('proteins.txt','w');

for i=1:4:length(pdb_ids)
    
    id = pdb_ids(i:i+3);
   
    PDBstruct = getpdb(id);
    
    if not(strcmp(PDBstruct.Header.classification, 'RNA') || strcmp(PDBstruct.Header.classification, 'DNA') ...
                || strcmp(PDBstruct.Header.classification,'DNA/RNA HYBRID'))
         fprintf(logfileID,['1. ' id ' - ' PDBstruct.Compound(2,:) '\n']);
    end
    
end

fclose('all');
