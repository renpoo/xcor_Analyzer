classdef oscillodemo < handle
    properties
        Fs=11025;
        t,yy,meanyy,lineyy,linecursor
        r,linemaxmin,linetrig
        linelsq,hdl,btn,triglevel,upedge,animation
        AC,uistartstop,uixcursor,uixcursortxt
        uimax,uimin,uitrig,uitrigtxt,uilsq,
        uilsqslider,uilsqstr,uiac,uidc,uiupedge,uidwnedge
        pupind,pdwnind
    end
    methods
        function this = oscillodemo
            close all;
            this.r = audiorecorder(this.Fs, 16, 1);
            recordblocking (this.r,0.5);
            y = getaudiodata(this.r, 'int16');
            this.t=((1:length(y))-1)/this.Fs;
            this.yy=double(y);
            this.meanyy=0;
            this.lineyy=plot(this.t,this.yy-this.meanyy);
            hold on
            this.linecursor(1)=plot(0,0,'g--');
            this.linecursor(2)=plot(0,0,'g--');
            this.linemaxmin(1)=plot(0,0,'r--');
            this.linemaxmin(2)=plot(0,0,'r--');
            this.linetrig(1)=plot(0,0,'g--');
            this.linetrig(2)=plot(0,0,'go');
            this.linelsq=plot(0,0,'r');
            hold off
            this.hdl=[];this.btn=0;this.triglevel=[];
            this.upedge=1;this.animation=1;this.AC=0;
            set(gcf,'units','normal');set(gca,'units','normal');
            set(gcf,'windowbuttondownfcn',@(~,~)adevent(this,1));
            set(gcf,'windowbuttonmotionfcn',@(~,~)adevent(this,2));
            set(gcf,'windowbuttonupfcn',@(~,~)adevent(this,0));
            set(gca,'position',[0.2 .12 .75 0.815]);
            this.uistartstop=...
                uicontrol('style','pushbutton','unit','normalized',...
                'position',[0 0.85 0.11 0.03],'string','Stop',...
                'callback',@(~,~)adupdateevent(this,0,this.AC,this.upedge));
            this.uixcursor=uicontrol('style','checkbox','unit','normalized',...
                'position',[0 0.80 0.11 0.03],'string','x corsor',...
                'callback',@(~,~)adupdateevent(this,0,this.AC,this.upedge));
            this.uixcursortxt=uicontrol('style','edit','unit','normalized',...
                'position',[0 0.75 0.17 0.05]);
            this.uimax=uicontrol('style','checkbox','unit','normalized',...
                'position',[0 0.70 0.11 0.03],'string','max','callback',...
                @(~,~)adupdate(this));
            this.uimin=uicontrol('style','checkbox','unit','normalized',...
                'position',[0 0.65 0.11 0.03],'string','min','callback',...
                @(~,~)adupdate(this));
            this.uitrig=uicontrol('style','checkbox','unit','normalized',...
                'position',[0 0.60 0.17 0.03],'string','trig level',...
                'callback',@(~,~)adupdateevent(this,0,this.AC,this.upedge));
            this.uitrigtxt=uicontrol('style','edit','unit','normalized',...
                'position',[0 0.55 0.17 0.05],'string','');
            this.uilsq=uicontrol('style','checkbox','unit','normalized',...
                'position',[0.02 0.50 0.15 0.03],'string','ls curvefit');
            this.uilsqslider=uicontrol('style','slider','unit','normalized',...
                'position',[0 0.45 0.17 0.03],'min',0,'max',6,'value',...
                0,'callback',@(~,~)adupdate(this));
            this.uilsqstr=uicontrol('style','edit','unit','normalized',...
                'position',[0 0.40 0.17 0.05]);
            this.uiac=uicontrol('style','radiobutton','unit','normalized',...
                'position',[0 0.30 0.08 0.03],'string','AC','value',...
                1,'callback',@(~,~)adupdateevent(this,this.animation,1,this.upedge));
            this.uidc=uicontrol('style','radiobutton','unit','normalized',...
                'position',[0.09 0.30 0.08 0.03],'string','DC',...
                'callback',@(~,~)adupdateevent(this,this.animation,0,this.upedge));
            this.uiupedge=uicontrol('style','radiobutton','string',...
                '—§‚¿ã‚è','position',[20 20 80 20],...
                'value',1,'callback',@(~,~)adupdateevent(this,this.animation,this.AC,1));
            this.uidwnedge=uicontrol('style','radiobutton','string',...
                '—§‚¿‰º‚è','position',[120 20 80 20],...
                'value',0,'callback',@(~,~)adupdateevent(this,this.animation,this.AC,0));
            adupdate(this);
            adrun(this);
        end
        function this = adsetpara(this,animation,AC,upedge)
            this.animation = animation;
            this.AC = AC;
            this.upedge = upedge;
        end
        function this=adupdateevent(this,animation,AC,upedge)
            adsetpara(this,animation,AC,upedge);
            adupdate(this);
            adevent(this,this.btn);
        end
        function this = adupdate(this)
            % AC/DC init %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if this.AC==1
                set(this.uidc,'value',0);
                set(this.uiac,'value',1);
                this.meanyy = mean(this.yy);
            else
                set(this.uidc,'value',1);
                set(this.uiac,'value',0);
                this.meanyy = 0;
            end
            [maxyval,~]=max(this.yy-this.meanyy);
            [minyval,~]=min(this.yy-this.meanyy);
            ylim([-abs(maxyval) abs(maxyval)]);
            set(this.lineyy,'ydata',this.yy-this.meanyy);
            %% maxmin%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if get(this.uimax,'value')==1
                set(this.linemaxmin(1),'xdata',this.t([1 end]),'ydata',...
                    [maxyval maxyval]-this.meanyy);
            else
                set(this.linemaxmin(1),'xdata',[],'ydata',[]);
            end
            if get(this.uimin,'value')==1
                set(this.linemaxmin(2),'xdata',this.t([1 end]),'ydata',...
                    [minyval minyval]-this.meanyy);
            else
                set(this.linemaxmin(2),'xdata',[],'ydata',[]);
            end
            %% for updown edge %%%%%%%%%%%%%%%%%%%%%%%%%%%
            if this.upedge==1
                set(this.uiupedge,'value',1);
                set(this.uidwnedge,'value',0);
            else set(this.uiupedge,'value',0);
                set(this.uidwnedge,'value',1);
            end
            %% for trigger%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if get(this.uitrig,'value')==1
                if isempty(this.triglevel)
                    set(this.linetrig(1),'xdata',xlim,'ydata',[0 0]);
                else
                    set(this.linetrig(1),'xdata',xlim,'ydata',[this.triglevel(1)
                        this.triglevel(1)]);
                    new_yy=conv(this.yy,ones(1,9)/9);
                    plogicval=(new_yy(5:(end-4)) >= this.triglevel(1));
                    if get(this.uiupedge,'value') ==1
                        this.pupind=strfind(plogicval(:)',[0 1]);
                        set(this.linetrig(2),'xdata',this.t(this.pupind),...
                            'ydata',this.yy(this.pupind)-this.meanyy);
                    else
                        this.pdwnind=strfind(plogicval(:)',[1 0]);
                        set(this.linetrig(2),'xdata',this.t(this.pdwnind),...
                            'ydata',this.yy(this.pdwnind)-this.meanyy);
                    end
                    if ~isempty(this.pupind)
                        % diff cannot handle less than 1 data
                        if length(this.pupind) > 1
                            set(this.uitrigtxt,'string',...
                                [num2str(mean(diff(this.t(this.pupind)))),'sec']);
                        end
                    end
                end
            else
                set(this.linetrig(1),'xdata',[],'ydata',[]);
                set(this.linetrig(2),'xdata',[],'ydata',[]);
                set(this.uitrigtxt,'string','');
            end
            % for lsq curvefit%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if get(this.uilsq,'value')== 1
                n=round(get(this.uilsqslider,'value'));
                A=this.t(:).^n;
                for i=(n-1):-1:0
                    A=[A this.t(:).^i];
                end
                B=this.yy(:)-this.meanyy;
                set(this.linelsq,'xdata',this.t,'ydata',A*(A\B));
                lsqpara=A\B;
                lsqstr=['y='];
                for i=1:n
                    if lsqpara(i)>0,pmstr='+';
                    else pmstr='-';end
                    lsqstr=[lsqstr,pmstr,num2str(abs(lsqpara(i))),'x^',num2str(n+1-i)];
                end
                if lsqpara(n+1)>0,pmstr='+';
                else pmstr='-';end
                lsqstr=[lsqstr,pmstr,num2str(abs(lsqpara(n+1)))];
                legend('y',lsqstr,0);
                set(this.uilsqstr,'string',['ŽŸ”=',num2str(n)]);
            else
                set(this.linelsq,'xdata',[],'ydata',[]);
            end
            % cursor init%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if get(this.uixcursor,'value')==1
                set(this.linecursor(1),'xdata',[0.2 0.2],'ydata',ylim);
                set(this.linecursor(2),'xdata',[0.3 0.3],'ydata',ylim);
                set(this.uixcursortxt,'string','0.1 sec');
            else
                set(this.linecursor(1),'xdata',[],'ydata',[]);
                set(this.linecursor(2),'xdata',[],'ydata',[]);
                set(this.uixcursortxt,'string','');
            end
        end
        function this = adevent(this,btn)
            this.btn = btn;
            % for animation %%%%%%%%%%%%%%%%%%%%%%%%
            if this.animation == 0
                set(this.uistartstop,'string','start','callback',@(~,~)adrun(this));
                set(gcf,'windowbuttondownfcn',@(~,~)adevent(this,1));
                set(gcf,'windowbuttonmotionfcn',@(~,~)adevent(this,2));
                set(gcf,'windowbuttonupfcn',@(~,~)adevent(this,0));
            end
            % for mouse event %%%%%%%%%%%%%%%%%%%%%%%%%%
            switch(this.btn)
                case 0,
                    if ~isempty(this.hdl)
                        if this.hdl == this.linetrig(1)
                            new_yy=conv(this.yy,ones(1,9)/9);
                            plogicval=(new_yy(5:(end-4)) >= this.triglevel(1));
                            this.pupind=strfind(plogicval(:)',[0 1]);
                            this.pdwnind=strfind(plogicval(:)',[1 0]);
                            if get(this.uiupedge,'value') ==1
                                set(this.linetrig(2),'xdata',this.t(this.pupind),...
                                    'ydata',this.yy(this.pupind)-this.meanyy);
                            else
                                set(this.linetrig(2),'xdata',this.t(this.pdwnind),...
                                    'ydata',this.yy(this.pdwnind)-this.meanyy);
                            end
                            if ~isempty(this.pupind)
                                if length(this.pupind) > 1
                                    ['ƒgƒŠƒKƒŒƒxƒ‹',num2str(this.triglevel(1)),'•½‹ÏŽüŠú',num2str(mean(diff(this.t(this.pupind))))]
                                end
                            end
                        end
                        set(this.hdl,'linewidth',1);
                    end
                    this.hdl = [];
                case 1,
                    if (gco == this.linetrig(1)) this.hdl=this.linetrig(1);end
                    if (gco == this.linecursor(1)) this.hdl=this.linecursor(1);end
                    if (gco == this.linecursor(2)) this.hdl=this.linecursor(2);end
                    if ~isempty(this.hdl) set(this.hdl,'linewidth',5);end
                case 2,
                    XX=get(gca,'currentpoint');
                    if ~isempty(this.hdl)
                        if this.hdl == this.linetrig(1)
                            set(this.hdl,'xdata',xlim,'ydata',[XX(1,2) XX(1,2)]);
                            this.triglevel=get(this.hdl,'ydata');
                            set(this.uitrigtxt,'string',num2str(this.triglevel(1)));
                        else
                            set(this.hdl,'xdata',[XX(1,1) XX(1,1)],'ydata',ylim);
                            haba=get(this.linecursor(1),'xdata')-get(this.linecursor(2),'xdata');
                            if ~isempty(haba)
                                set(this.uixcursortxt,'string',[num2str(abs(haba(1))),'sec']);
                            end
                        end
                    end
            end
        end
        function this = adrun(this)
            this.animation = 1;
            set(1,'interruptible','on','windowbuttondownfcn',@(~,~)adsetpara(this,0,this.AC,this.upedge));
            set(this.uistartstop,'string','stop','callback',@(~,~)adupdateevent(this,0,this.AC,this.upedge));
            while (this.animation)
                recordblocking (this.r,0.5);
                y = getaudiodata(this.r, 'int16');
                this.yy=double(y);
                adupdate(this);
                drawnow;
            end;
            set(1,'interruptible','on','windowbuttondownfcn',@(~,~)adrun(this));
        end
    end
end