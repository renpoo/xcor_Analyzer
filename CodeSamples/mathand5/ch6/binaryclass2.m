classdef binaryclass2
    properties
        c
    end
    methods
        function p = binaryclass2(a)
            if nargin == 0
                p.c  = 0;
            elseif isa(a,'binaryclass2')
                p=a;
            else
                if nargin == 1
                    [f,bit]=log2(max(a));
                    p.c = rem(floor(a*pow2(1-max(2,bit):0)),2);
                else error('input must be scalar');
                end
            end
        end
        function display(p)
            fprintf('(binary) ');
            fprintf([inputname(1),' = ']);
            aa = [];
            for ii=1:length(p.c)
                aa=[aa,num2str(p.c(ii))];
            end
            fprintf(aa);fprintf('\n');
        end
    end
end
