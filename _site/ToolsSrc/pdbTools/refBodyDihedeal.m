function  sys=refBodyDihedeal(sys,ini,final)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    bodyList  = fieldnames(sys.body{1});
    Numbody=length(bodyList);
    
    for replica=[ini,final]
        AntresName=nan;

        energy=0;
        for idx = 1:Numbody
            Namecorpo = bodyList{idx};
            corpo=sys.body{replica}.(Namecorpo);                  
                corpo.phi=0;
                corpo.psi=0;
                if mod(idx,2)==0 
                    
                    resName=corpo.resName;
                    
                    if idx>=4 && idx<=Numbody-2

                        %fprintf('%s\n',corpo.resName);
                        % evaluate dihedral angle 1
                        CA=corpo.point.CA.rP;
                        N=corpo.point.N.rP;
                        C=corpo.point.C.rP;
                        AminoAntNamecorpo = bodyList{idx-1};
                        AminoAnt=sys.body{replica}.(AminoAntNamecorpo);
                        AntC=AminoAnt.point.C.rP;
                        Phi=calcDihedralAngle(AntC,N,CA,C);

                        % evaluate dihedral angle 2
                        AminoProxNamecorpo = bodyList{idx+1};
                        AminoProx=sys.body{replica}.(AminoProxNamecorpo);
                        NProx=AminoProx.point.N.rP;
                        Psi=calcDihedralAngle(N,CA,C,NProx);
                        % index in the bin domain

                        Ni= mod(round((Phi+pi)*sys.options.binAng/(2*pi)+0.5),sys.options.binAng+1);
                        Nj= mod(round((Psi+pi)*sys.options.binAng/(2*pi)+0.5),sys.options.binAng+1);
                        if Ni==0
                            Ni=1;
                        end
                        if Nj==0
                            Nj=1;
                        end
                        % Gradient

                        Grad=sys.W1.(resName);

                        corpo.phi=Phi;
                        corpo.psi=Psi;


                        % System energy
                        energy=energy+Grad.f(1,Nj,Ni);

                        corpoA=AminoAnt;
                        % index in the bin domain
                        NiA= mod(round((corpoA.phi+pi)*sys.options.binAng/(2*pi)+0.5),sys.options.binAng+1);
                        NjA= mod(round((corpoA.psi+pi)*sys.options.binAng/(2*pi)+0.5),sys.options.binAng+1);
                        if NiA==0
                            NiA=1;
                        end
                        if NjA==0
                            NjA=1;
                        end                              


                        f1=sys.W2.([AntresName resName]).f(1,Nj,NiA);
                        f3=sys.W2.([AntresName resName]).f(2,Ni,NjA);
                        f5=sys.W2.([AntresName resName]).f(3,Nj,NjA); 



                        % Energy
                         energy=energy+0.05*(f1+f3+f5);
                   
                    end
                    AntresName=resName;
                end
                sys.body{replica}.(Namecorpo)=corpo;
                
        end
        sys.Refenergy(replica)=energy;
    end
end

