%%
% Analysing window 1
%

%clear all
%clc
%close all
%format long

addpath pdbTools CircStat

KC_C = 326;
KN_C = 250;

MeandC_CA= 1.52;
MeandN_CA= 1.45;

bin=pi/180*8.6;
kappa=5;
bin=80;

NumBins=round(2*pi/bin)+1;

bins=@(omega) round((pi+omega)/bin)+1;

%filter=@(dC_CA,dN_CA,dP_plane) not(abs(dC_CA-1.99)>0.5 || abs(dN_CA-1.78)>0.4 || abs(dP_plane-1.47)>0.3);
filter=@(dC_CA,dN_CA,dP_plane,Bfactor) not(abs(dC_CA-1.52)>0.03 || abs(dN_CA-1.47)>0.03 || abs(dP_plane-1.32)>0.03 || Bfactor>40);
%filter=@(dC_CA,dN_CA,dP_plane) not(dC_CA<2*1.76 || dN_CA<2*1.7 || dP_plane<2*1.7);
%filter=@(dC_CA,dN_CA,dP_plane)1;

%aminos={'PHE'; 'ASP'; 'THR'; 'ARG'; 'TRP'; 'VAL'; 'CYS'; 'SER'; 'ALA'; 'GLY'; 'MET'; 'TYR'; 'ASN'; 'PRO'; 'LYS'; 'HIS'; 'GLN'; 'ILE'; 'LEU'; 'GLU'};
aminos={'CYS'}
varName={'phi', 'psi', 'dC_CA','dN_CA','dN_C','dP_plane', 'ang_N_CA_C','R1','R2','R3','R4'};

for i=1:length(aminos)   
    aminoName=aminos{i}
    
    Data=importdata(['aminoData/' aminoName '.cvs']);
    
    if ~isempty(Data)
        
        [l,col]=size(Data);
        
        dataT=removenan(Data,filter); % clean and select data
        
        %%
        % Amino discrete characteristic
        %
        [l,c]=size(dataT);
        idx=randperm(l);
        data=dataT(idx(1:end),:);
        
        %%
        % Amino discrete characteristic
        %
        
        [l,c]=size(data);
        num=round(l/3);
        
        phi= data(1:end,1);
        psi= data(1:end,2);
        
        [p1 nbins ]=circ_hist(bin,phi, psi);

        figure
        
        imagesc(-log(p1));
        title([aminoName ': phi vs psi']);
        xlabel('phi');
        ylabel('psi');
        %%axis([-180 180 -180 180]);
        colorbar;
        
        
        
        phi= data(num:2*num,1);
        psi= data(num:2*num,2);
        
        [p2 nbins]=circ_hist(bin,phi, psi);
        
        phi= data(2*num:end,1);
        psi= data(2*num:end,2);
        
        [p3 nbins]=circ_hist(bin,phi, psi);
        
        norm(p1-p2)
        norm(p2-p3)
        norm(p1-p3)
        
        figure
        
        imagesc((p1-p2).^2);
        title([aminoName ': phi vs psi']);
        xlabel('phi');
        ylabel('psi');
        %%axis([-180 180 -180 180]);
        colorbar;
        
        
        figure
        
        imagesc((p2-p3).^2);
        title([aminoName ': phi vs psi']);
        xlabel('phi');
        ylabel('psi');
        %%axis([-180 180 -180 180]);
        colorbar;
                
        figure
        
        imagesc((p1-p3).^2);
        title([aminoName ': phi vs psi']);
        xlabel('phi');
        ylabel('psi');
        %%axis([-180 180 -180 180]);
        colorbar;
        
        
                
        
        
end
end

