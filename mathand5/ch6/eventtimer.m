classdef eventtimer < handle
    properties
        timerobj
    end
    events
        sampleevent
    end
    methods
        function this = eventtimer(period)
            this.timerobj = timer( ...
                'ExecutionMode', 'fixedRate', ...
                'Period', period, ...
                'TimerFcn', @(src,event) this.notify( 'sampleevent' ) );
            start(this.timerobj);
        end
        function delete(this)
            stop(this.timerobj);
        end
    end
end
