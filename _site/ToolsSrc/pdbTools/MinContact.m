function  body=MinContact(body)
% Change multi-body configurantion by changing at random
% the dihedral angle
%
%   angle=coef*rand([-1,1])
%
    global SubBody;
    global sys;
    
    NumbodyAux=sys.Numbody;
    
    NumbodyRes=sys.NumRefAngs;

    nvars=NumbodyAux-1+NumbodyRes;
    ini=zeros(nvars,1);
    Min=-pi*ones(nvars,1);
    Max=pi*ones(nvars,1);
    
    if 1
        algorithm='active-set';
        display='iter';
        [ang,~,history,~] = runfmincon('FunctionObj',ini,Min,Max,algorithm,display,'on','off');
        figure;
        plot(history.fval);
    else
        options = gaoptimset('PopulationSize',10);
        [ang,fval] = ga(@FunctionObj, nvars,options);
    end
    
    
    for idxbody = 2:NumbodyAux-2;
        Namecorpo = sys.bodyList{idxbody};
        corpo=body.(Namecorpo);
        if mod(idxbody,2)==1
            ProxNamecorpo = sys.bodyList{idxbody+1};
            Proxcorpo=body.(ProxNamecorpo);
            v=-Proxcorpo.vector.CA_N.s;
            p=Proxcorpo.point.N.rP;
            r=ang(idxbody);
        else
            v=corpo.vector.CA_C.s;
            p=corpo.point.CA.rP;
            r=ang(idxbody);
            resName=corpo.resName;
            
                            % rotate residuum
                if ~strcmp(resName,'GLY')
                    subbody=SubBody.(resName);
                    bodylist=subbody.bodies;
                    ncorpos=length(bodylist);
                    for idx=1:ncorpos-1
                        Name=bodylist{idx};
                        NameProx=bodylist{idx+1};
                        subcorpo=corpo.point.(Name);
                        subcorpoProx=corpo.point.(NameProx);
                        vp=subcorpoProx.rP-subcorpo.rP;
                        rP=ang(sys.RefAng(idxbody/2)+idx-1);

                        R= rotationmat3D(-rP,vp);

                        for idx2=idx:ncorpos
                            Name=bodylist{idx2};
                            pointList=subbody.(Name);
                            numPoints=length(pointList);
                            for i=1:numPoints
                                Nameponto=pointList{i};
                                ponto=corpo.point.(Nameponto);
                                aux = R*(ponto.rP-subcorpo.rP)+subcorpo.rP;
                                corpo.point.(Nameponto).rP=aux ;
                            end
                        end
                    end
                end
        end
        R= rotationmat3D(-r,v);

        % Start  body
        for idx = idxbody+1:NumbodyAux
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

