classdef userevent < handle
    properties
        username
    end
    methods
        function this = userevent(username1)
            this.username = username1;
        end
        function addtimer(this, obj)
            addlistener( obj, 'sampleevent', @(src,event) this.timerevent);
        end
        function timerevent(this)
            fprintf('%s',this.username);
        end
    end
end
