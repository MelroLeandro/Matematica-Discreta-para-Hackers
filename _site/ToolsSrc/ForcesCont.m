function aminoCont = ForcesCont( aminoName, binAng)
%
% Computes dihedral and rotamer angles for a given amino 
%

addpath pdbTools CircStat

SbinAng=int2str(binAng);
bin=pi/180*binAng;

NumBins=round(2*pi/bin)+1;

bins=@(omega) round((pi+omega)/bin)+1;

%filter=@(dC_CA,dN_CA,dP_plane,Bfactor) not(abs(dC_CA-1.52)>0.03 || abs(dN_CA-1.47)>0.03 || abs(dP_plane-1.32)>0.03 || Bfactor>40);
filter=@(dC_CA,dN_CA,dP_plane,Bfactor) 1;
    
Data=importdata(['aminoData/' aminoName '.cvs']);

if ~isempty(Data)

[l,col]=size(Data);

data=removenan(Data,filter); % clean and select data

%%
% Amino discrete characteristic
%
phi= data(:,1);
psi= data(:,2);

% bounds
C_CA= data(:,3);
N_CA= data(:,4);
dplane= data(:,6);

[f,w1]=circ_vmpar(phi);
[f,w2]=circ_vmpar(psi);

fprintf('\t\t\t\t Prossecing phi,psi\n');
[p nbins]=circ_vmpdf2(binAng, phi, psi, w1, w2);



aminoCont.f(1,:,:)=-log(p);


fprintf('\t\t\t\t Prossecing Grad(phi,psi)\n');

[d1p,d2p] = imgradientxy(-log(p));
aminoCont.dfx(1,:,:)=d1p;
aminoCont.dfy(1,:,:)=d2p;

aminoCont.N_rota=col-8;

if col> 8
            chsi1= data(:,9);
            
            fprintf('\t\t\t\t Prossecing phi,chsi1\n');
            [f,w3]=circ_vmpar(chsi1);
            [p nbins]=circ_vmpdf2(binAng, phi, chsi1, w1,w3);
            aminoCont.f(2,:,:)=-log(p);
            
            fprintf('\t\t\t\t Prossecing Grad(phi,chsi1)\n');
            
            [d1p,d2p] = imgradientxy(-log(p));
            aminoCont.dfx(2,:,:)=d1p;
            aminoCont.dfy(2,:,:)=d2p;
            
            fprintf('\t\t\t\t Prossecing psi,chsi1\n');
            [p nbins]=circ_vmpdf2(binAng, psi, chsi1, w2,w3);
            aminoCont.f(3,:,:)=-log(p);
            
            fprintf('\t\t\t\t Prossecing Grad(psi,chsi1)\n');
            
            [d1p,d2p] = imgradientxy(-log(p));
            aminoCont.dfx(3,:,:)=d1p;
            aminoCont.dfy(3,:,:)=d2p;


            if col > 9                        
                chsi2= data(:,10);

                [f,w4]=circ_vmpar(chsi2);
                fprintf('\t\t\t\t Prossecing chsi1,chsi2\n');
                [p nbins]=circ_vmpdf2(binAng, chsi1, chsi2, w3,w4);
                aminoCont.f(4,:,:)=-log(p);
                
                fprintf('\t\t\t\t Prossecing Grad(chsi1,chsi2)\n');
                
                [d1p,d2p] = imgradientxy(-log(p));
                aminoCont.dfx(4,:,:)=d1p;
                aminoCont.dfy(4,:,:)=d2p;

                if col > 10

                    chsi3= data(:,11);


                    [f,w5]=circ_vmpar(chsi3);
                    fprintf('\t\t\t\t Prossecing chsi2,chsi3\n');
                    [p nbins]=circ_vmpdf2(binAng, chsi2, chsi3, w4,w5);
                    aminoCont.f(5,:,:)=-log(p);

                    fprintf('\t\t\t\t Prossecing Grad(chsi2,chsi3)\n');
                    
                    [d1p,d2p] = imgradientxy(-log(p));
                    aminoCont.dfx(5,:,:)=d1p;
                    aminoCont.dfy(5,:,:)=d2p;

                    if col > 11

                        chsi4= data(:,12);
                        
                        fprintf('\t\t\t\t Prossecing chsi3,chsi4\n');
                        [f,w6]=circ_vmpar(chsi4);
                        [p nbins]=circ_vmpdf2(binAng, chsi3, chsi4, w5,w6);
                        aminoCont.f(6,:,:)=-log(p);
                        fprintf('\t\t\t\t Prossecing Grad(chsi3,chsi4)\n');
                        
                        [d1p,d2p] = imgradientxy(-log(p));
                        aminoCont.dfx(6,:,:)=d1p;
                        aminoCont.dfy(6,:,:)=d2p;

                    end
                end
            end
end


save(['contData/Mises' aminoName SbinAng '.mat'],'aminoCont');        
end


