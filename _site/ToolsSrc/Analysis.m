%%
% 
% Analysis: A simple script used to scan the extracted data for each
% aminoacid ploting distribution graphs for dihedral angles and bond
% lengths
%
%  Dependences: importdata, removenan, ksdensity, circ_vmpdf2
%  libs:        pdbTools, CircStat

clear all
clc
close all
format long

addpath pdbTools CircStat

KC_C = 326;
KN_C = 250;

MeandC_CA= 1.52;
MeandN_CA= 1.45;

binAng = 180;

bin=pi/binAng*8.6;
kappa=5;

NumBins=round(2*pi/bin)+1;

bins=@(omega) round((pi+omega)/bin)+1;

%filter=@(dC_CA,dN_CA,dP_plane,Bfactor) not(abs(dC_CA-1.99)>1.18 || abs(dN_CA-1.78)>0.91 || abs(dP_plane-1.47)>0.55);
%filter=@(dC_CA,dN_CA,dP_plane,Bfactor) not(dC_CA<2*1.76 || dN_CA<2*1.7 || dP_plane<2*1.7);
%filter=@(dC_CA,dN_CA,dP_plane)1;
filter=@(dC_CA,dN_CA,dP_plane,Bfactor) 1;
%filter=@(dC_CA,dN_CA,dP_plane,Bfactor)not(Bfactor>16);

aminos={'PHE'; 'ASP'; 'THR'; 'ARG'; 'TRP'; 'VAL'; 'CYS'; 'SER'; 'ALA'; 'GLY'; 'MET'; 'TYR'; 'ASN'; 'PRO'; 'LYS'; 'HIS'; 'GLN'; 'ILE'; 'LEU'; 'GLU'};
%aminos={'PHE'}


% Attributes extrated from the protein db:
% dihedral angles............. phi, psi
% bond distance............... dC_CA, dN_CA, dN_C
% plolypetid plane............ dP_plan
% angle....................... ang_N_CA_C
% side chain dihedral angles.. R1, R2, R3, R4
varName={'phi', 'psi', 'dC_CA','dN_CA','dN_C','dP_plane', 'ang_N_CA_C','R1','R2','R3','R4'};

for i=1:length(aminos)   
    aminoName=aminos{i}
    % import the data in CSV format used to the statistical analysies
    %
    Data=importdata(['aminoData/' aminoName '.cvs']);
    file = fopen(['_posts/2015-04-03-Amino-' aminoName  '.markdown'],'w');
    
    fprintf(file,'---\n');
    fprintf(file,'layout: post\n');
    fprintf(file,['title:  "Amino ' aminoName '"\n']);
    fprintf(file,['date:   2015-04-03 15:01:' num2str(i) ' +0100\n']);
    %fprintf(file,['date:   2015-04-03 15:01:' num2str(1) ' +0100\n']);
    fprintf(file,'categories: update\n');
    fprintf(file,'---\n');
    fprintf(file,'<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?');
    fprintf(file,'config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>');

    fprintf(file,'\n\n![Image](../../../../images/aadensity.png)\n');
    
    fprintf(file,['\n# Amino ' aminoName '\n\n']);
    
    %% Statistics
      if ~isempty(Data)
        
        [l,col]=size(Data);
        
       
        
        BFactor= Data(:,8);
        BFactor_bar= mean(BFactor);
        
        [c1,att]=size(Data);
        
        fprintf(file,'\n SAMPLE SIZE: %d\n',c1);
        
        fprintf(file,' \n \n \n');
        % B-factor
        
        fprintf(file,'|     | B-factor |\n');
        fprintf(file,'| --- | --- |\n');
        fprintf(file,'| Mean | %.2f |\n',BFactor_bar);
        fprintf(file,'| Median | %.2f |\n',median(BFactor));
        fprintf(file,'| Variance | %.2f |\n',var(BFactor));
        
        fprintf(file,'| Standard deviation | %.2f |\n',std(BFactor));
        fprintf(file,'| Skewness | %.2f |\n',skewness(BFactor));
        fprintf(file,'| Kurtosis | %.2f |\n',kurtosis(BFactor));

        fprintf(file,' \n \n \n');
        
        % Filter Data
        data=removenan(Data,filter); % clean and select data
        
        % query points
        phi= data(:,1);
        psi= data(:,2);
        
        % bounds
        C_CA= data(:,3);
        N_CA= data(:,4);
        dplane= data(:,6);
        
        fprintf(file,'\n|     | C-CA | N-CA | peptid plane |\n');
        fprintf(file,'| --- | --- | --- | --- |\n');
        
        C_CA_bar= mean(C_CA);
        N_CA_bar= mean(N_CA);
        dplane_bar= mean(dplane);
        
        fprintf(file,'| Mean | %.2f | %.2f | %.2f |\n',C_CA_bar,N_CA_bar,dplane_bar);
        fprintf(file,'| Median | %.2f | %.2f | %.2f |\n',median(C_CA),median(N_CA),median(dplane));
        fprintf(file,'| Variance | %.2f | %.2f | %.2f |\n',var(C_CA),var(N_CA),var(dplane));
        
        fprintf(file,'| Standard deviation | %.2f | %.2f | %.2f |\n',std(C_CA),std(N_CA),std(dplane));
        fprintf(file,'| Skewness | %.2f | %.2f | %.2f |\n',skewness(C_CA),skewness(N_CA),skewness(dplane));
        fprintf(file,'| Kurtosis | %.2f | %.2f | %.2f |\n',kurtosis(C_CA),kurtosis(N_CA),kurtosis(dplane));
        
        
        R = corrcoef([C_CA N_CA dplane]);
        
        fprintf(file,'| corrcoef | %.2f | %.2f | %.2f |\n',R(1,1),R(1,2),R(1,3));
        fprintf(file,'| corrcoef | %.2f | %.2f | %.2f |\n',R(2,1),R(2,2),R(2,3));
        fprintf(file,'| corrcoef | %.2f | %.2f | %.2f |\n',R(3,1),R(3,2),R(3,3));
        
        %% part 1: descriptive statistics
        fprintf(file,' \n \n \n');

        fprintf(file,'\n|     | PHI | PSI |');
        fprintf(file,'\n| --- | --- | --- |');

        alpha_bar = circ_mean(phi);
        beta_bar = circ_mean(psi);

        fprintf(file,'\n| Mean | %.2f | %.2f |\n', circ_rad2ang([alpha_bar beta_bar]));

        alpha_hat = circ_median(phi);
        beta_hat = circ_median(psi);

        fprintf(file,'| Median | %.2f | %.2f |\n', circ_rad2ang([alpha_hat beta_hat]));

        R_alpha = circ_r(phi);
        R_beta = circ_r(psi);

        fprintf(file,'| R Length | %.2f | %.2f |\n',[R_alpha R_beta]);

        S_alpha = circ_var(phi);
        S_beta = circ_var(psi);

        fprintf(file,'| Variance | %.2f | %.2f |\n',[S_alpha S_beta]);

        [s_alpha s0_alpha] = circ_std(phi);
        [s_beta s0_beta] = circ_std(psi);

        fprintf(file,'| Standard deviation | %.2f | %.2f |\n',[s_alpha s_beta]);
        fprintf(file,'| Standard deviation 0 | %.2f | %.2f |\n',[s0_alpha s0_beta]);

        b_alpha = circ_skewness(phi);
        b_beta = circ_skewness(psi);

        fprintf(file,'| Skewness | %.2f | %.2f |\n',[b_alpha b_beta]);

        k_alpha = circ_kurtosis(phi);
        k_beta = circ_kurtosis(psi);

        fprintf(file,'| Kurtosis | %.2f | %.2f |\n',[k_alpha k_beta]);

        fprintf(' \n \n \n')
        
        %% part 4: inferential statistics

        fprintf(file,'\n### Inferential Statistics for $$\\phi$$-$$\\psi$$ \n');
        fprintf(file,'\nTests for Uniformity\n');
        % Rayleigh test
        p_alpha = circ_rtest(phi);
        p_beta = circ_rtest(psi);
        fprintf(file,'\n- Rayleigh Test, P = %.2f %.2f',[p_alpha p_beta]);

        % Omnibus test
        p_alpha = circ_otest(phi);
        p_beta = circ_otest(psi);
        fprintf(file,'\n- Omnibus Test,  P = %.2f %.2f',[p_alpha p_beta]);

        % Rao's spacing test
        p_alpha = circ_raotest(phi);
        p_beta = circ_raotest(psi);
        fprintf(file,'\n- Rao Spacing Test,  P = %.2f %.2f',[p_alpha p_beta]);

        % V test
        p_alpha = circ_vtest(phi,circ_ang2rad(0));
        p_beta = circ_vtest(psi,circ_ang2rad(0));
        fprintf(file,'\n- V Test (r = 0),  P = %.2f %.2f',[p_alpha p_beta]);


        %% part 4: association
        fprintf(file,'\n### Measures of Association $$\\phi$$-$$\\psi$$\n')
        fprintf(file,'\nCircular-Circular Association');
        
        % compute circular - circular correlations
        [c p] = circ_corrcc(phi,psi);
        fprintf(file,'\n- Circ-circ corr phi-psi coeff/pval:\t%.2f\t %.3f',c,p);
        
        % compute circular - linear correlations
        [c p] = circ_corrcl(phi,C_CA);
        fprintf(file,'\n- Circ-line corr phi-C-CA coeff/pval:\t%.2f\t %.3f',c,p);
        
        [c p] = circ_corrcl(phi,N_CA);
        fprintf(file,'\n- Circ-line corr phi-N-CA coeff/pval:\t%.2f\t %.3f',c,p);
        
        [c p] = circ_corrcl(psi,C_CA);
        fprintf(file,'\n- Circ-line corr psi-C-CA coeff/pval:\t%.2f\t %.3f',c,p);
        
        [c p] = circ_corrcl(psi,N_CA);
        fprintf(file,'\n- Circ-line corr psi-N-CA coeff/pval:\t%.2f\t %.3f',c,p);
             
        
        if col> 7
                    chsi1= data(:,8);
                    fprintf(file,'\n### Statistics $$\\chi_1$$\n');
                    fprintf(file,'\n|     | CHI_1 |');
                    fprintf(file,'\n| --- | --- |');
                    chsi1_bar = circ_mean(chsi1);
                    fprintf(file,'\n| Mean resultant vector | %.2f |', circ_rad2ang(chsi1_bar));
                    chsi1_hat = circ_median(chsi1);
                    fprintf(file,'\n| Median | %.2f | %.2f |', circ_rad2ang(chsi1_bar));
                    R_chsi1 = circ_r(chsi1);
                    fprintf(file,'\n| R Length | %.2f | %.2f |',R_chsi1);
                    S_chsi1 = circ_var(chsi1);
                    fprintf(file,'\n| Variance | %.2f | %.2f |',S_chsi1);
                    [s_chsi1 s0_chsi1] = circ_std(chsi1);
                    fprintf(file,'\n| Standard deviation | %.2f |',s_chsi1);
                    fprintf(file,'\n| Standard deviation 0| %.2f |',s0_chsi1);
                    b_chsi1 = circ_skewness(chsi1);
                    fprintf(file,'\n| Skewness | %.2f |',b_chsi1);
                    k_chsi1 = circ_kurtosis(chsi1);
                    fprintf(file,'\n| Kurtosis | %.2f |\n',k_chsi1);
                    
                    fprintf(file,'\n \n');
                    %% part 4: inferential statistics
                    fprintf(file,'\n### Inferential Statistics $$\\chi_1$$');
                    fprintf(file,'\nTests for Uniformity\n');
                    % Rayleigh test
                    p_chsi1 = circ_rtest(chsi1);
                    fprintf(file,'\n- Rayleigh Test, \t P = %.2f',p_chsi1);
                    % Omnibus test
                    p_chsi1 = circ_otest(chsi1);
                    fprintf(file,'\n- Omnibus Test, \t P = %.2f',p_chsi1);
                    % Rao's spacing test
                    p_chsi1 = circ_raotest(chsi1);
                    fprintf(file,'\n- Rao Spacing Test, \t P = %.2f',p_chsi1);
                    
                    [c p] = circ_corrcc(phi,chsi1);
                    fprintf(file,'\n- Circ-circ corr phi-chi1 coeff/pval:\t%.2f\t %.3f',c,p);
                    [c p] = circ_corrcc(psi,chsi1);
                    fprintf(file,'\n- Circ-circ corr psi-chi1 coeff/pval:\t%.2f\t %.3f\n',c,p);
                    
                    if col > 8                        
                        chsi2= data(:,9);
                        
                        fprintf(file,'\n \n');
                        fprintf(file,'\n### Statistics $$\\chi_2$$\n');
                        
                        fprintf(file,'\n|     | CHI_2 |');
                        fprintf(file,'\n| --- | --- |');
                    
                        chsi2_bar = circ_mean(chsi2);
                        fprintf(file,'\n| Mean resultant vector | %.2f |', circ_rad2ang(chsi2_bar));
                        chsi2_hat = circ_median(chsi2);
                        fprintf(file,'\n| Median | %.2f |', circ_rad2ang(chsi2_bar));
                        R_chsi2 = circ_r(chsi2);
                        fprintf(file,'\n| R Length | %.2f |',R_chsi2);
                        S_chsi2 = circ_var(chsi2);
                        fprintf(file,'\n| Variance | %.2f |',S_chsi2);
                        [s_chsi2 s0_chsi2] = circ_std(chsi2);
                        fprintf(file,'\n| Standard deviation | %.2f |',s_chsi2);
                        fprintf(file,'\n| Standard deviation 0 | %.2f |',s0_chsi2);
                        b_chsi2 = circ_skewness(chsi2);
                        fprintf(file,'\n| Skewness | %.2f |',b_chsi2);
                        k_chsi2 = circ_kurtosis(chsi2);
                        fprintf(file,'\n| Kurtosis | %.2f |',k_chsi2);
                        fprintf(file,'\n\n');
                        %% part 4: inferential statistics
                        fprintf(file,'\n### Inferential Statistics $$\\chi_2$$ \n');
                        fprintf(file,'\nTests for Uniformity\n');
                        % Rayleigh test
                        p_chsi2 = circ_rtest(chsi2);
                        fprintf(file,'\n- Rayleigh Test, \t P = %.2f',p_chsi2);
                        % Omnibus test
                        p_chsi2 = circ_otest(chsi2);
                        fprintf(file,'\n- Omnibus Test, \t P = %.2f',p_chsi2);
                        % Rao's spacing test
                        p_chsi2 = circ_raotest(chsi2);
                        fprintf(file,'\n- Rao Spacing Test, \t P = %.2f',p_chsi2);
                        [c p] = circ_corrcc(phi,chsi2);
                        fprintf(file,'\n- Circ-circ corr phi-chi2 coeff/pval:\t%.2f\t %.3f',c,p);
                        [c p] = circ_corrcc(psi,chsi2);
                        fprintf(file,'\n- Circ-circ corr psi-chi2 coeff/pval:\t%.2f\t %.3f',c,p);
                        [c p] = circ_corrcc(chsi1,chsi2);
                        fprintf(file,'\n- Circ-circ corr chi1-chi2 coeff/pval:\t%.2f\t %.3f\n\n',c,p);
                        
                        if col > 9
                            
                            chsi3= data(:,10);
                            
                            fprintf(file,'\n \n');
                            fprintf(file,'\n### Statistics $$\\chi_3$$\n');
                            
                            fprintf(file,'\n|    | CHI_3 |');
                            fprintf(file,'\n| --- | --- |');
                            chsi3_bar = circ_mean(chsi3);
                            fprintf(file,'\n| Mean resultant vector | %.2f |', circ_rad2ang(chsi3_bar));
                            chsi3_hat = circ_median(chsi3);
                            fprintf(file,'\n| Median | %.2f |', circ_rad2ang(chsi3_bar));
                            R_chsi3 = circ_r(chsi3);
                            fprintf(file,'\n| R Length | %.2f |',R_chsi3);
                            S_chsi3 = circ_var(chsi3);
                            fprintf(file,'\n| Variance | %.2f |',S_chsi3);
                            [s_chsi3 s0_chsi3] = circ_std(chsi3);
                            fprintf(file,'\n| Standard deviation | %.2f |',s_chsi3);
                            fprintf(file,'\n| Standard deviation 0 | %.2f |',s0_chsi3);
                            b_chsi3 = circ_skewness(chsi3);
                            fprintf(file,'\n| Skewness | %.2f |',b_chsi3);
                            k_chsi3 = circ_kurtosis(chsi3);
                            fprintf(file,'\n| Kurtosis | %.2f |\n',k_chsi3);
                            fprintf(file,'\n\n');
                            %% part 4: inferential statistics
                            fprintf(file,'\n### Inferential Statistics $$\\chi_3$$\n');
                            fprintf(file,'\nTests for Uniformity\n');
                            % Rayleigh test
                            p_chsi3 = circ_rtest(chsi3);
                            fprintf(file,'\n- Rayleigh Test, \t P = %.2f',p_chsi3);
                            % Omnibus test
                            p_chsi3 = circ_otest(chsi3);
                            fprintf(file,'\n- Omnibus Test, \t P = %.2f',p_chsi3);
                            % Rao's spacing test
                            p_chsi3 = circ_raotest(chsi3);
                            fprintf(file,'\n- Rao Spacing Test, \t P = %.2f',p_chsi3);

                            [c p] = circ_corrcc(phi,chsi3);
                            fprintf(file,'\n- Circ-circ corr phi-chi3 coeff/pval:\t%.2f\t %.3f',c,p);
        
                            [c p] = circ_corrcc(psi,chsi3);
                            fprintf(file,'\n- Circ-circ corr psi-chi3 coeff/pval:\t%.2f\t %.3f',c,p);
                        
                            [c p] = circ_corrcc(chsi1,chsi3);
                            fprintf(file,'\n- Circ-circ corr chi1-chi3 coeff/pval:\t%.2f\t %.3f',c,p);
                            
                            [c p] = circ_corrcc(chsi2,chsi3);
                            fprintf(file,'\n- Circ-circ corr chi2-chi3 coeff/pval:\t%.2f\t %.3f',c,p);
        
                            
                            if col > 10
                                
                                chsi4= data(:,11);
                                
                                fprintf(file,'\n### Statistics $$\\chi_4$$\n');
                                
                                fprintf(file,'\n|     | CHI_4 |');
                                fprintf(file,'\n| --- | --- |');
                                chsi4_bar = circ_mean(chsi4);
                                fprintf(file,'\n| Mean resultant vector | %.2f |', circ_rad2ang(chsi4_bar));
                                chsi4_hat = circ_median(chsi4);
                                fprintf(file,'\n| Median | %.2f |', circ_rad2ang(chsi4_bar));
                                R_chsi4 = circ_r(chsi4);
                                fprintf(file,'\n| R Length | %.2f |',R_chsi4);
                                S_chsi4 = circ_var(chsi4);
                                fprintf(file,'\n| Variance | %.2f |',S_chsi4);
                                [s_chsi4 s0_chsi4] = circ_std(chsi4);
                                fprintf(file,'\n| Standard deviation | %.2f |',s_chsi4);
                                fprintf(file,'\n| Standard deviation 0 | %.2f |',s0_chsi4);
                                b_chsi4 = circ_skewness(chsi4);
                                fprintf(file,'\n| Skewness | %.2f |',b_chsi4);
                                k_chsi4 = circ_kurtosis(chsi4);
                                fprintf(file,'\n| Kurtosis | %.2f |',k_chsi4);
                                fprintf(file,'\n\n');
                                %% part 4: inferential statistics
                                fprintf(file,'\n## Inferential Statistics $$\\chi_4$$\n');
                                fprintf(file,'\nTests for Uniformity\n');
                                % Rayleigh test
                                p_chsi4 = circ_rtest(chsi4);
                                fprintf(file,'\n- Rayleigh Test, \t P = %.2f',p_chsi4);
                                % Omnibus test
                                p_chsi4 = circ_otest(chsi4);
                                fprintf(file,'\n- Omnibus Test, \t P = %.2f',p_chsi4);
                                % Rao's spacing test
                                p_chsi4 = circ_raotest(chsi4);
                                fprintf(file,'\n- Rao Spacing Test, \t P = %.2f',p_chsi4);

                            
                                [c p] = circ_corrcc(phi,chsi4);
                                fprintf(file,'\n- Circ-circ corr phi-chi4 coeff/pval:\t%.2f\t %.3f',c,p);
        
                                [c p] = circ_corrcc(psi,chsi4);
                                fprintf(file,'\n- Circ-circ corr psi-chi4 coeff/pval:\t%.2f\t %.3f',c,p);
                        
                                [c p] = circ_corrcc(chsi1,chsi4);
                                fprintf(file,'\n- Circ-circ corr chi1-chi4 coeff/pval:\t%.2f\t %.3f',c,p);
                            
                                [c p] = circ_corrcc(chsi2,chsi4);
                                fprintf(file,'\n- Circ-circ corr chi2-chi4 coeff/pval:\t%.2f\t %.3f',c,p);
                                
                                [c p] = circ_corrcc(chsi3,chsi4);
                                fprintf(file,'\n- Circ-circ corr chi3-chi4 coeff/pval:\t%.2f\t %.3f\n',c,p);
        
                            end
                        end
                    end
        end
    end
    
    %%
    
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
        
        fprintf(file,'\n\n# $$\\phi$$ & $$\\psi$$\n')
                
        figure
        [f,w1]=circ_vmpar(phi);
        [f,w2]=circ_vmpar(psi);
        [p nbins]=circ_vmpdf2(binAng, phi, psi, w1, w2);
        p=Rmatrix(p');
        imagesc(-log(p));
        title([aminoName ': psi vs phi']);
        xlabel('psi');
        ylabel('phi');
        %axis([-180 180 -180 180]);
        colorbar;
       
        print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_phipsi.jpg'));
        
        fprintf(file,['![Image](../../../../images/' aminoName '_Rama_phipsi.jpg)\n']);
                    
        figure
        
        [d1p,d2p] = imgradientxy(-log(p));
        imagesc(sqrt(d1p.^2+d2p.^2));
        title([aminoName ':norm(Grad) phi vs psi']);
        xlabel('psi');
        ylabel('phi');
        %axis([-180 180 -180 180]);
        colorbar;
             
        print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_phipsiGrad.jpg'))
        fprintf(file,['![Image](../../../../images/' aminoName '_Rama_phipsiGrad.jpg)\n']);
    
        
        
        if col> 8
                    chsi1= data(:,9);
                    
                    fprintf(file,'\n\n# $$\\chi_1$$\n')
                    
                    figure
                    [f,w3]=circ_vmpar(chsi1);
                    [p nbins]=circ_vmpdf2(binAng, phi, chsi1, w1,w3);
                    p=Rmatrix(p');
                    imagesc(-log(p));
                    title([aminoName ':phi vs chi1']);
                    xlabel('chi1');
                    ylabel('phi');
                    %axis([-180 180 -180 180]);
                    colorbar;
                    
                    print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_phichi1.jpg'))
                    fprintf(file,['![Image](../../../../images/' aminoName '_Rama_phichi1.jpg)\n']);
                    
        
                    figure
                    
                    [d1p,d2p] = imgradientxy(-log(p));
                    imagesc(sqrt(d1p.^2+d2p.^2));
                    title([aminoName ':norm(Grad) phi vs chi1']);
                    xlabel('chi1');
                    ylabel('phi');
                    %axis([-180 180 -180 180]);
                    colorbar;
                                     
                    print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_Grad_psichi1.jpg'))
                    fprintf(file,['![Image](../../../../images/' aminoName '_Rama_Grad_psichi1.jpg)\n']);

                    
                    figure
                    
                    [p nbins]=circ_vmpdf2(binAng, psi, chsi1, w2,w3);
                    %[p nbins]=circ_vmpdf2(binAng, psi, chsi1, w2,w3,p);
                    p=Rmatrix(p');
                    imagesc(-log(p));
                    title([aminoName ':psi vs chi1']);
                    xlabel('chi1');
                    ylabel('psi');
                    %axes('Position',[-180 180 -180 180]);
                    colorbar;
                    
                    print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_psichi1.jpg'))
                    fprintf(file,['![Image](../../../../images/' aminoName '_Rama_psichi1.jpg)\n']);
                    
        
                    figure

                    [d1p,d2p] = imgradientxy(-log(p));
                    aminoCont.dfx(3,:,:)=d1p;
                    aminoCont.dfy(3,:,:)=d2p;
                    imagesc(sqrt(d1p.^2+d2p.^2));
                    title([aminoName ':norm(Grad) psi vs chi1']);
                    xlabel('psi');
                    ylabel('chi1');
                    %axis([-180 180 -180 180]);
                    colorbar;
                    
                    
                    print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_Grad_phichi1.jpg'))
                    fprintf(file,['![Image](../../../../images/' aminoName '_Rama_Grad_phichi1.jpg)\n']);

                    
                    if col > 9                        
                        chsi2= data(:,10);
                        
                        fprintf(file,'\n\n# $$\\chi_2$$\n')
                        
                        figure
                        [f,w4]=circ_vmpar(chsi2);
                        [p nbins]=circ_vmpdf2(binAng, chsi1, chsi2, w3,w4);
                        p=Rmatrix(p');
                        imagesc(-log(p));
                        title([aminoName ':chi1 vs chi2']);
                        xlabel('chi2');
                        ylabel('chi1');
                        %axis([-180 180 -180 180]);
                        colorbar;    
                        
                        print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_chi1chi2.jpg'))
                        fprintf(file,['![Image](../../../../images/' aminoName '_Rama_chi1chi2.jpg)\n']);
                   

                        figure

                        [d1p,d2p] = imgradientxy(-log(p));
                        imagesc(sqrt(d1p.^2+d2p.^2));
                        title([aminoName ':norm(Grad) chi1 vs chi2']);
                        xlabel('chi2');
                        ylabel('chi1');
                        %axis([-180 180 -180 180]);
                        colorbar;
                        
                        print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_Gradchi1chi2.jpg'))
                        fprintf(file,['![Image](../../../../images/' aminoName '_Rama_Gradchi1chi2.jpg)\n']);
                    
                    
                        if col > 10
                            
                            chsi3= data(:,11);
                            
                            fprintf(file,'\n\n# $$\\chi_3$$\n')

                            figure
                            [f,w5]=circ_vmpar(chsi3);
                            [p nbins]=circ_vmpdf2(binAng, chsi2, chsi3, w4,w5);
                            p=Rmatrix(p');
                            imagesc(-log(p))
                            title([aminoName ':chi2 vs chi3']);
                            xlabel('chi3');
                            ylabel('chi2');
                            %axis([-180 180 -180 180]);
                            colorbar;
                            
                            print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_chsi2chi3.jpg'))
                            fprintf(file,['![Image](../../../../images/' aminoName '_Rama_chsi2chi3.jpg)\n']);
                    

                            figure

                            [d1p,d2p] = imgradientxy(-log(p));
                            imagesc(sqrt(d1p.^2+d2p.^2));
                            title([aminoName ':norm(Grad) chi2 vs chi3']);
                            xlabel('chi3');
                            ylabel('chi2');
                            %axis([-180 180 -180 180]);
                            colorbar;    
                            
                            print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_Gradchsi2chi3.jpg'))
                            fprintf(file,['![Image](../../../../images/' aminoName '_Rama_Gradchsi2chi3.jpg)\n']);
                    
                            
                            if col > 11
                                
                                figure
                                chsi4= data(:,12);

                                fprintf(file,'\n\n# $$\\chi_4$$\n')
                                [f,w6]=circ_vmpar(chsi4);
                                [p nbins]=circ_vmpdf2(binAng, chsi3, chsi4, w5,w6);
                                p=Rmatrix(p');
                                imagesc(-log(p));
                                title([aminoName ':chi3 vs chi4']);
                                xlabel('chi4');
                                ylabel('chi3');
                                %axis([-180 180 -180 180]);
                                colorbar;
                                
                                print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_chi3chi4.jpg'))
                                fprintf(file,['![Image](../../../../images/' aminoName '_Rama_chi3chi4.jpg)\n']);
                    


                                figure

                                [d1p,d2p] = imgradientxy(-log(p));
                                imagesc(sqrt(d1p.^2+d2p.^2));
                                title([aminoName ':norm(Grad) chi3 vs chi4']);
                                xlabel('chi4');
                                ylabel('chi3');
                                %axis([-180 180 -180 180]);
                                colorbar;
                                
                                print(gcf,'-djpeg',strcat('images/',aminoName,'_Rama_Gradchi3chi4.jpg'))
                                fprintf(file,['![Image](../../../../images/' aminoName '_Rama_Gradchi3chi4.jpg)\n']);
                    
                                
                            end
                        end
                    end
        end
        
        
%         %%
%         % Amino discrete characteristic
%         %
%         %% 
%         
%         data=[bins(Data(:,1)) bins(Data(:,2)) Data(:,3:end)];
%                 
%         amino.count=zeros(NumBins,NumBins,8);
%         
%         for i=1:NumBins
%             for j=1:NumBins
%                 infor.dC_CA=[];
%                 infor.dN_CA=[];
%                 infor.R1=[];
%                 infor.R2=[];
%                 infor.R3=[];
%                 infor.R4=[];
%                 amino=setfield(amino,['R' int2str(i) 'x' int2str(j)],infor);
%             end
%         end
%         
%         
%         for idx=1:l
%             i=data(idx,1);
%             j=data(idx,2);
%             k=1;
%             if ~(isnan(i) || isnan(j)) %&& filter(data(idx,3),data(idx,4),data(idx,6))
%                 amino.count(i,j,1)=amino.count(i,j,1)+1;
% 
%                 BIN = ['R' int2str(i) 'x' int2str(j)];
% 
%                 dataBIN = getfield(amino,BIN); 
% 
%                 dataBIN.dC_CA=[dataBIN.dC_CA data(idx,3)];
%                 dataBIN.dN_CA=[dataBIN.dN_CA data(idx,4)];
%                 if col>7 && ~isnan(data(idx,8))
%                     dataBIN.R1=[dataBIN.R1 data(idx,8)];
%                     k1=bins(data(idx,8));
%                     amino.count(i,k1,2)=amino.count(i,k1,2)+1;
%                     amino.count(k1,j,3)=amino.count(k1,j,3)+1;
%                     if col>8 && ~isnan(data(idx,9))
%                         dataBIN.R2=[dataBIN.R2 data(idx,9)];
%                         k2=bins(data(idx,9));
%                         amino.count(i,k2,4)=amino.count(i,k2,4)+1;
%                         amino.count(k2,j,5)=amino.count(k2,j,5)+1;
%                         amino.count(k1,k2,6)=amino.count(k1,k2,6)+1;
%                         if col>9 && ~isnan(data(idx,10))
%                             dataBIN.R3=[dataBIN.R3 data(idx,10)];
%                             k3=bins(data(idx,10));
%                             amino.count(k1,k3,7)=amino.count(k1,k3,7)+1;
%                             amino.count(k2,k3,8)=amino.count(k2,k3,8)+1;
%                             if col> 10 && ~isnan(data(idx,11))
%                                 dataBIN.R4=[dataBIN.R4 data(idx,11)];
%                             end
%                         end
%                     end
%                 end
%                 amino=setfield(amino,BIN,dataBIN);
%             end
%         end
%         
%         amino=setfield(amino,'Size',l);
%         amino=setfield(amino,'NumBins',NumBins);
%         
%         amino.MeandC_CA=zeros(NumBins,NumBins);
%         amino.VardC_CA=zeros(NumBins,NumBins);
%         amino.mindC_CA=zeros(NumBins,NumBins);
%         amino.MeanddN_CA=zeros(NumBins,NumBins);
%         amino.VardN_CA=zeros(NumBins,NumBins);
%         amino.mindN_CA=zeros(NumBins,NumBins);
%         if col>7
%             amino.MeanR1=zeros(NumBins,NumBins);
%             amino.VarR1=zeros(NumBins,NumBins);
%             if col>8
%                 amino.MeanR2=zeros(NumBins,NumBins);
%                 amino.VarR2=zeros(NumBins,NumBins);
%                 if col>9
%                     amino.MeanR3=zeros(NumBins,NumBins);
%                     amino.VarR3=zeros(NumBins,NumBins);
%                     if col> 10
%                         amino.MeanR4=zeros(NumBins,NumBins);
%                         amino.VarR4=zeros(NumBins,NumBins);
%                     end
%                 end
%             end
%         end
%         for i=1:NumBins
%             for j=1:NumBins
%                 BIN = ['R' int2str(i) 'x' int2str(j)];            
%                 dataBIN = getfield(amino,BIN);
%                 
%                 amino.MeandC_CA(i,j)=mean(dataBIN.dC_CA);
%                 amino.VardC_CA(i,j)=var(dataBIN.dC_CA);
%                 
%                 m=min(dataBIN.dC_CA);
%                 if ~isempty(m)
%                     amino.minC_CA(i,j)=m;
%                 else
%                     amino.minC_CA(i,j)=nan;
%                 end
%                 
%                 amino.MeandN_CA(i,j)=mean(dataBIN.dN_CA);
%                 amino.VardN_CA(i,j)=var(dataBIN.dN_CA);
%                 
%                 m=min(dataBIN.dN_CA);
%                 if ~isempty(m)
%                     amino.minN_CA(i,j)=m;
%                 else
%                     amino.minN_CA(i,j)=nan;
%                 end
%                 
%                 if col>7
%                     amino.MeanR1(i,j)=mean(dataBIN.R1);
%                     amino.VarR1(i,j)=var(dataBIN.R1);
%                     if col>8
%                         amino.MeanR2(i,j)=mean(dataBIN.R2);
%                         amino.VarR2(i,j)=var(dataBIN.R2);
%                         if col>9
%                             amino.MeanR3(i,j)=mean(dataBIN.R3);
%                             amino.VarR3(i,j)=var(dataBIN.R3);
%                             if col> 10
%                                 amino.MeanR4(i,j)=mean(dataBIN.R4);
%                                 amino.VarR4(i,j)=var(dataBIN.R4);
%                             end
%                         end
%                     end
%                 end
%             end
%         end
    end
    
        fclose('all');
end


