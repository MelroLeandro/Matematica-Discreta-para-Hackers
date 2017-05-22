
%%
% Protein measurement
%
%      Description: Given a set of selected proteins, in the PDB format, each
%      in this function each is decomposed in its aminoacides.
%      Since the protein conformation is caracterazed by a set o measures, we extratected
%      and clouter this information describe the aminoacid local conformation.

%      The information extratected is saved for indevidual aminos. It includes
%      dihedral angles for each conformation where  this amino is presence. Each conformation is
%      charaterised by its phi, psi, dC_CA, dN_CA, dN_C, dP_plane,
%      ang_N_CA_C, chi1, chi2, chi3, chi4 e TempFactor.

%      Similar information is recorded for windows with two and three aminos.
%      The some data for sequences with two aminos. When the window is defined by
%      three aminoacids we only record phi, psi and the angle omega.

%      The set of PDB's files mast be save in the folder 'proteinData' and
%      the selected proteins used for data aggregation must be listed in 'pdb1A.tsv'.

%      Input: A list indentifing PDB files in 'pdb1A.tsv':
%      Output: Three type of files
%      Aminoacid mectric saved in 'aminoData/<amino>.csv' those include
%            - phi, psi, dC_CA, dN_CA, dN_C, dP_plane, ang_N_CA_C, chi1, chi2, chi3, chi4 e TempFactor.
%      Por each pair of aminoacids we save in 'aminoData/<amino1><amino2>.csv'
%            - phi1, psi1, dC_CA1, dN_CA1, dN_C1, dP_plane1, ang_N_CA_C1, chi11, chi12, chi13, chi14, TempFactor1,
%              phi2, psi2, omega, dC_CA2, dN_CA2, dN_C2, dP_plane2, ang_N_CA_C2, chi21, chi22, chi23, chi24 e TempFactor2
%      For each permutation of three aminoacids we saved in 'rotamer_w3_lib.csv'
%            - phi1, psi1, phi2, psi2, omega1, phi3, psi3, omega1

% By Carlos Leandro, 2015
% mellean@gmail.com - www.ghithub.com/MelroLeandro/??
%
% Uses: protain in file pdb1A.tsv
% Generates: proteinDB matlab format file
%            add dihedral angles
%                seq aminos with atoms
%            split informatio by amino
%                 window 1r  'aminoData/' amino '.cvs'
%                 data:
%                      phi, psi, dC_CA, dN_CA, dN_C, dP_plane, ang_N_CA_C,Rotamers(1),Rotamers(2),Rotamers(3),Rotamers(4));
%                      tempFactor
%                 window 2r  'aminoData/' amino amino2 '.cvs'
%                 data:
%                   r1   phi, psi, dC_CA, dN_CA, dN_C, dP_plane, ang_N_CA_C,Rotamers(1),Rotamers(2),Rotamers(3),Rotamers(4));
%                   r2   phi, psi, omega, dC_CA, dN_CA, dN_C, dP_plane, ang_N_CA_C,Rotamers(1),Rotamers(2),Rotamers(3),Rotamers(4));
%                   tempFactor
%                 window 3r  rotamer_w3_lib
%                   r1   phi, psi,
%                   r2   phi, psi, omega
%                   r3   phi, psi, omega
%                   tempFactor

% Dependences:
%               pdbTools - functions to dihedral angle evaluation

clear all
clc
close all
format long

addpath  proteinDB pdbTools

% A set with aminoacid identifications
aminos={'PHE'; 'ASP'; 'THR'; 'ARG'; 'TRP'; 'VAL'; 'CYS'; 'SER'; 'ALA'; 'GLY'; 'MET'; 'TYR'; 'ASN'; 'PRO'; 'LYS'; 'HIS'; 'GLN'; 'ILE'; 'LEU'; 'GLU'};


%% Read protein pdb_ids
%

single_pdb=0; % if 0 reads from file

rotamer_w3_lib='rotamer_w3.cvs';

if single_pdb==1
     pdb_ids='1UAO';
else
    % Select protein list
    pdb_file_list='pdb1A.tsv';

    % Read protein list
    pdblistID = fopen(pdb_file_list,'r');
    pdb_ids = fscanf(pdblistID, '%s');
    fclose(pdblistID);
end

%%
% Reads each protein
%

for i=1:4:length(pdb_ids)
    %%
    % Open log File
    logfileID = fopen('logfile.txt','a');
    fprintf(logfileID,'-----------------\n');
    fprintf(logfileID,'-  %s \n',datestr(now));
    fprintf(logfileID,'-----------------\n');

    % Select protein pdb file
    input_pdb_file = [pdb_ids(i:i+3) '.pdb'];
    output_pdb_file = [pdb_ids(i:i+3) '.mat'];

    % Check existence
    if  exist(['proteinData/' output_pdb_file],'file')==2
        fprintf(logfileID,'Existent %s...\n',output_pdb_file);
        continue
    end

    %%
    % Reding PDB
    %
    fprintf(logfileID,'Reading %s...\n',input_pdb_file);
    
    if  exist(input_pdb_file,'file')~=2
        try
            fprintf(logfileID,'importing %s...\n',pdb_ids(i:i+3));
            PDBstruct = getpdb(pdb_ids(i:i+3));
            pdbwrite(['proteinDB/' input_pdb_file],PDBstruct);
         catch
            fprintf(logfileID,'\tError importing...\n');
            continue
        end
    else
        fprintf(logfileID,' %s is in the DB\n',pdb_ids(i:i+3));
    end
    
    try
        PDBstruct = pdbread(input_pdb_file);

        if not(strcmp(PDBstruct.Header.classification, 'RNA') || strcmp(PDBstruct.Header.classification, 'DNA') ...
                || strcmp(PDBstruct.Header.classification,'DNA/RNA HYBRID'))

            %%
            % Dihedral angles on main-chain and rotamers-chain
            %
            fprintf(logfileID,'\tStarting MainChain_ang...%s\n',PDBstruct.Header.classification);
            tic;
            MainChain_ang = Torsion(PDBstruct,logfileID);
            t=toc;
            fprintf(logfileID,'\t\ttime:%f\n',t);

            fprintf(logfileID,'\tRotamerChain_ang...\n');
            tic;
            RotamerChain_ang = Rotamer(PDBstruct,logfileID);
            t=toc;
            fprintf(logfileID,'\t\ttime:%f\n',t);
            %%
            % Update PDB struct
            %
            fprintf(logfileID,'\tUpdating PDB struct...\n');
            PDBstruct=setfield(PDBstruct,'MainChain_ang',MainChain_ang);
            PDBstruct=setfield(PDBstruct,'RotamerChain_ang',RotamerChain_ang);

            %%
            % Check struct
            %


            rotamer_w3 = fopen(rotamer_w3_lib,'a');

            file=[];
            for i=1:length(aminos)
                amino=aminos{i};
                newfile = fopen(['aminoData/' amino '.cvs'],'a');
                file=setfield(file,amino,newfile);
                for j=1:length(aminos)
                    amino2=aminos{j};
                    newfile = fopen(['aminoData/' amino amino2 '.cvs'],'a');
                    file=setfield(file,[amino amino2],newfile);
                end
            end

            num_amino=length(RotamerChain_ang);

            for i=1:num_amino
                if not(strcmp(MainChain_ang(i).resName, RotamerChain_ang{i}.resName))
                    fprintf(logfileID,'\t\tError res %d\n',i);
                    continue
                end
                amino1=MainChain_ang(i).resName;
                newfile1=getfield(file,amino1);
                if not(isnan(MainChain_ang(i).phi) || isnan(MainChain_ang(i).psi))
                   fprintf(newfile1,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',...
                   MainChain_ang(i).phi, ...
                   MainChain_ang(i).psi, ...
                   MainChain_ang(i).dC_CA, ...
                   MainChain_ang(i).dN_CA, ...
                   MainChain_ang(i).dN_C, ...
                   MainChain_ang(i).dP_plane, ...
                   MainChain_ang(i).ang_N_CA_C,...
                   max(MainChain_ang(i).tempFactor,RotamerChain_ang{i}.tempFactor),...
                   RotamerChain_ang{i}.Rotamers(1),...
                   RotamerChain_ang{i}.Rotamers(2),...
                   RotamerChain_ang{i}.Rotamers(3),...
                   RotamerChain_ang{i}.Rotamers(4));
                   if i+1<=num_amino
                       amino2=MainChain_ang(i+1).resName;
                       newfile2=getfield(file,[amino1 amino2]);
                       fprintf(newfile2,'%f,%f,%f,%f,%f,%f,%f,%f,',...
                       MainChain_ang(i).phi, ...
                       MainChain_ang(i).psi, ...
                       MainChain_ang(i).dC_CA, ...
                       MainChain_ang(i).dN_CA, ...
                       MainChain_ang(i).dN_C, ...
                       MainChain_ang(i).dP_plane, ...
                       MainChain_ang(i).ang_N_CA_C,...
                       max(MainChain_ang(i).tempFactor,MainChain_ang(i+1).tempFactor));
                       fprintf(newfile2,'%f,%f,%f,%f,%f,%f,%f,%f\n',...
                       MainChain_ang(i+1).phi, ...
                       MainChain_ang(i+1).psi, ...
                       MainChain_ang(i+1).omega, ...
                       MainChain_ang(i+1).dC_CA, ...
                       MainChain_ang(i+1).dN_CA, ...
                       MainChain_ang(i+1).dN_C, ...
                       MainChain_ang(i+1).dP_plane, ...
                       MainChain_ang(i+1).ang_N_CA_C);
                   end
                   if i+2<=num_amino
                       fprintf(rotamer_w3,'%s,%s,%s,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',...
                       MainChain_ang(i).resName,...
                       MainChain_ang(i+1).resName,...
                       MainChain_ang(i+2).resName,...
                       MainChain_ang(i).phi, ...
                       MainChain_ang(i).psi, ...
                       MainChain_ang(i+1).phi, ...
                       MainChain_ang(i+1).psi, ...
                       MainChain_ang(i+1).omega, ...
                       MainChain_ang(i+2).phi, ...
                       MainChain_ang(i+2).psi,...
                       MainChain_ang(i+2).omega,...
                       max([MainChain_ang(i).tempFactor,MainChain_ang(i+1).tempFactor,MainChain_ang(i+1).tempFactor]));
                   end
                end
            end


            save(['proteinData/' output_pdb_file],'PDBstruct');

            fprintf(logfileID,'\t\t OK\n',output_pdb_file);
        else
             fprintf(logfileID,'\tDNA...\n');
         end
        catch
            fprintf(logfileID,'\tError...\n');
            continue
        end
        fclose('all');
end
