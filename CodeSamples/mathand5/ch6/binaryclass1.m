classdef binaryclass1
	properties
		c
	end
	methods
		function p = binaryclass1(a)
			if nargin == 0
				p.c  = 0;
			elseif isa(a,'binaryclass1')
				p=a;
			else
				if nargin == 1
					[f,bit]=log2(max(a));
					p.c = rem(floor(a*pow2(1-max(2,bit):0)),2);
				else error('input must be scalar');
				end
			end
		end
	end
end
