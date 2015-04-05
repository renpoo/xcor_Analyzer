classdef binaryclass4
    properties
        c
    end
    methods
        function p = binaryclass4(a)
            if nargin == 0
                p.c  = 0;
            elseif isa(a,'binaryclass4')
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
        function val = double(p)
            pow2dat = pow2(length(p.c)-1:-1:0);
            val = sum(p.c .* pow2dat);
        end
        function val = plus(p,q)
            val = binaryclass4(double(p)+double(q));
        end
    end
end
