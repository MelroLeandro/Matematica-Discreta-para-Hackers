function  body=ChangeConvexConf(coef,body,bodyinit,bodyend,num)
% Change multi-body configurantion by changing at random
% the dihedral angle
%
%   angle=coef*rand([-1,1])
%
    global sys; 
    
    lambda=coef/num;
    
    for idxbody = 3:sys.Numbody-2;
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
            body.(Namecorpo).phi=r;
            r=(1-lambda)*corpoinit.psi+lambda*corpoend.psi;
            %r=lambda*corpoinit.psi+(1-lambda)*corpoend.psi;
            body.(Namecorpo).psi=r;
        else %phi
            Namecorpo = sys.bodyList{idxbody+1};
            corpoinit=bodyinit.(Namecorpo);
            corpoend=bodyend.(Namecorpo);
            r=(1-lambda)*corpoinit.phi+lambda*corpoend.phi;
            %r=lambda*corpoinit.phi+(1-lambda)*corpoend.phi;
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

