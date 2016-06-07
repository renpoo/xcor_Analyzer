function Answer = ConvertScaleToString_( scale )
precision = 2;

s = floor( scale );
if (scale - s >= 0.5)
    s = s + 1;
end;
s = s * precision;



smod = mod( s, (12 * precision) );
soct = round( s / (12 * precision) );

Answer = '';

switch smod
    case 0
        Answer = 'A';
    case 1
        Answer = 'A+';
    case 2
        Answer = 'A#';
    case 3
        Answer = 'A#+';
    case 4
        Answer = 'B';
    case 5
        Answer = 'B+';
    case 6
        Answer = 'C';
    case 7
        Answer = 'C+';
    case 8
        Answer = 'C#';
    case 9
        Answer = 'C#+';
    case 10
        Answer = 'D';
    case 11
        Answer = 'D+';
    case 12
        Answer = 'D#';
    case 13
        Answer = 'D#+';
    case 14
        Answer = 'E';
    case 15
        Answer = 'E+';
    case 16
        Answer = 'F';
    case 17
        Answer = 'F+';
    case 18
        Answer = 'F#';
    case 19
        Answer = 'F#+';
    case 20
        Answer = 'G';
    case 21
        Answer = 'G+';
    case 22
        Answer = 'G#';
    otherwise
        Answer = 'G#+';
end;

Answer = sprintf( '%s%d', Answer, (soct + 1) );
