classdef colorclass3
    % This is help
    properties
        red=1
        green=2
        blue=3
    end
    methods(Access = private)
        function r=getR(p)
            r = p.red;
        end
        function g=getG(p)
            g = p.green;
        end
        function b=getB(p)
            b = p.blue;
        end
    end
    methods
        function showRGB(p)
           fprintf('r = %d,g = %d, b = %d\n',p.getR(),p.getG(),p.getB());
        end
    end
end
