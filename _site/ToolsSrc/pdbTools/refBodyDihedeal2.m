function  sys=refBodyDihedeal2(sys,ini,final)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    bodyList  = fieldnames(sys.body{1});
    Numbody=length(bodyList);
    
    for replica=[ini,final]
        AntresName=nan;
        Anti=nan;
        Antj=nan;

        energy=0;
        for idx = 1:Numbody
            Namecorpo = bodyList{idx};
            corpo=sys.body{replica}.(Namecorpo);                  
                corpo.phi=0;
                corpo.psi=0;
                if mod(idx,2)==0 && idx>=4 && idx<=Numbody-2
                    resName=corpo.resName;

                    %fprintf('%s\n',corpo.resName);
                    % evaluate dihedral angle 1
                    CA=corpo.point.CA.rP;
                    N=corpo.point.N.rP;
                    C=corpo.point.C.rP;
                    AminoAntNamecorpo = bodyList{idx-1};
                    AminoAnt=sys.body{1}.(AminoAntNamecorpo);
                    AntC=AminoAnt.point.C.rP;
                    Phi=calcDihedralAngle(AntC,N,CA,C);

                    % evaluate dihedral angle 2
                    AminoProxNamecorpo = bodyList{idx+1};
                    AminoProx=sys.body{1}.(AminoProxNamecorpo);
                    NProx=AminoProx.point.N.rP;
                    Psi=calcDihedralAngle(N,CA,C,NProx);
                    % index in the bin domain

                    i= round((Phi+pi)*sys.options.binAng/(2*pi)+0.5);
                    j= round((Psi+pi)*sys.options.binAng/(2*pi)+0.5);
                    % Gradient

                    Grad=sys.W1.(resName);

                    corpo.phi=Phi;
                    corpo.psi=Psi;


                    % System energy
                    energy=energy+Grad.f(i,j);
                end
                sys.body{replica}.(Namecorpo)=corpo;
        end
        sys.Refenergy(replica)=energy;
    end
end

