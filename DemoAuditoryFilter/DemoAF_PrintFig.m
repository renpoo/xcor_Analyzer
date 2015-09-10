%
%     Demonstrations for introducting auditory filters
%     DemoAF_PrintFig
%     Irino, T.
%     Created:  20 Mar 2010
%     Modified: 20 Mar 2010
%     Modified: 11 May 2010 (function)
%     Modified: 25 Jun 2010 (eps)
%     Modified: 27 Jul 2010 (SwEps = 0)
%     Modified: 18 Aug 2010 (Linewidth)
%     Modified:  2 Sep 2010 (No print on Octave)
%     Modified: 25 May 2015 (introduction of SwPrint)
%
%
function DemoAF_PrintFig(NameFig,SwPrint)

if nargin < 2, SwPrint = []; end;
if length(SwPrint)==0, SwPrint = 1; end;

if exist('OCTAVE_VERSION') > 0,
    warning('No print on Octave.');
    SwPrint = 0;
    return;
end;

if SwPrint  < 1
    warning(['No print.  SwPrint = ' int2str(SwPrint) '.']);
    return;
end;

%% for MATLAB
    
set(0,'DefaultTextFontSize',12);
set(0,'DefaultAxesFontSize',12);

if 0
  set(0,'DefaultAxesLinewidth', 1.0);  
  set(0,'DefaultLineLinewidth', 1.0);  
  set(0,'DefaultPatchLinewidth', 1.0);
end;

set(gcf,'PaperOrientation','portrait');
set(gcf,'PaperUnits','centimeters');
set(gcf,'PaperPosition',[3 8 14 12]);
str = ['print -dpng -r300 ' NameFig];
eval(str);

%SwEps = 1;
SwEps = SwPrint;
if SwEps == 1,
   str = ['print -deps ' NameFig];
   eval(str);  
end;



%%%
%set(hx,'Interpreter','latex'); 
%set(hy,'Interpreter','latex'); 

