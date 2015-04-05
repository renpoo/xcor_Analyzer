classdef handletest1
    properties
        a = 0
    end
    methods
        function display(obj)
            fprintf('%s = %d\n',inputname(1),obj.a);
        end
    end
end
