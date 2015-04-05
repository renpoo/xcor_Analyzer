color='yellow';
switch lower(color)
	case {'y','yellow'}, disp('Yellow')
	case {'m','magenta'}, disp('Magenta')
	case {'c','cyan'}, disp('Cyan')
	case {'r','red'}, disp('Red')
	case {'g','green'}, disp('Green')
	case {'b','blue'}, disp('Blue')
	case {'w','white'}, disp('White')
	case {'k','black'}, disp('Black')
	otherwise, disp('Unknown color.')
end
