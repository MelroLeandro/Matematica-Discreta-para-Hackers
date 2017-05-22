function  sys=ResetConf(sys)
% Change multi-body configurantion by changing at random
% the dihedral angle
%
%   angle=coef*rand([-1,1])
%
     
    
    bodyList  = fieldnames(sys.body);
    Numbody=length(bodyList);
    
    NumbodyAux=Numbody;
    
    for idxbody = 3:NumbodyAux-2;
        Namecorpo = bodyList{idxbody};
        corpo=sys.body.(Namecorpo);
        if mod(idxbody,2)==1
            v=corpo.vector.N_CA.s;
            p=corpo.point.N.rP;
            r=corpo.phi;
        else
            v=corpo.vector.CA_C.s;
            p=corpo.point.CA.rP;
            r=corpo.psi;
        end

        R= rotationmat3D(r,v);

        % Start  body
        for idx = idxbody+1:Numbody
                NamecorpoSeq = bodyList{idx};
                corpoSeq=sys.body.(NamecorpoSeq);

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

               sys.body.(NamecorpoSeq)= corpoSeq; 
        end
    end

end

