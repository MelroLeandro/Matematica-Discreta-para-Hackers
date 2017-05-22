function atom = convert(Name)
            if Name(1)=='C'
                atom='C';
            elseif Name(1)=='N'
                atom='N';
            elseif Name(1)=='O'
                atom='O';
            elseif Name(1)=='H'
                atom='H';
            elseif Name(1)=='S'
                atom='S';
            else
                atom=Name;
            end
end

