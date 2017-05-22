function [body,Phi,Psi]=ChangeConvexConf2(BodyRefidx,coef,body,bodyinit,bodyend,num,replica,Phi,Psi)
% Change multi-body configurantion by changing at random
% the dihedral angle
%
%   angle=coef*rand([-1,1])
%
    global sys; 
    
    lambda=coef/num;
    
    for idxbody = 4:sys.Numbody-1;
        Namecorpo = sys.bodyList{idxbody};
        corpo=body.(Namecorpo);

        if mod(idxbody,2)==1
            v=corpo.vector.N_CA.s;
            p=corpo.point.N.rP;
        else
            v=corpo.vector.CA_C.s;
            p=corpo.point.CA.rP;
        end

        if mod(idxbody,2)==0 %psi
            corpoinit=bodyinit.(Namecorpo);
            corpoend=bodyend.(Namecorpo);
            r=(1-lambda)*corpoinit.psi+lambda*corpoend.psi;
            corpo.psi=r;

            %if(BodyRefidx==idxbody)
            Psi(1,idxbody/2-1)=corpoinit.psi;
            Psi(replica,idxbody/2-1)=r;
            Psi(num,idxbody/2-1)=corpoend.psi;
            %end
            r=(1-lambda)*corpoinit.phi+lambda*corpoend.phi;
            corpo.phi=r;
            Phi(1,(idxbody)/2-1)=corpoinit.phi;
            Phi(replica,(idxbody)/2-1)=r;
            Phi(num,(idxbody)/2-1)=corpoend.phi;
        else %phi
            Namecorpo = sys.bodyList{idxbody+1};
            corpoinit=bodyinit.(Namecorpo);
            corpoend=bodyend.(Namecorpo);
            r=(1-lambda)*corpoinit.phi+lambda*corpoend.phi;
            %if(BodyRefidx==idxbody)
            %end
        end

        R= rotationmat3D(r,v);

        % Start  body
        for idx = idxbody+1:sys.Numbody
                NamecorpoSeq = sys.bodyList{idx};
                corpoSeq=body.(NamecorpoSeq);

                pointList  = fieldnames(corpoSeq.point);
                Numpoint=length(pointList);

                % Rotate center

                corpoSeq.r=R*(corpoSeq.r-p)+p;
                %
                % Update Pontos
                %
                for i = 1:Numpoint
                    Nameponto = pointList{i};
                    ponto=corpoSeq.point.(Nameponto);

                    ponto.rP = R*(ponto.rP-p)+p;    

                    corpoSeq.point.(Nameponto)=ponto;
                end

                vectorList  = fieldnames(corpoSeq.vector);
                Numvector=length(vectorList);

                % Cálcula vectores vectore
                for j = 1:Numvector
                    Namevector = vectorList{j};
                    vector=corpoSeq.vector.(Namevector);

                    vector.s=R*vector.s;

                    corpoSeq.vector.(Namevector)=vector;
                end        

               body.(NamecorpoSeq)= corpoSeq; 
        end
    end

end

