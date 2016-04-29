function ARR_scaage_boxplot_function(data,papersize,label,fontsize,fontsize_axes,fonttype,filename,x_label,y_label,ages)
figure1 = figure('Visible','on',...
           'PaperPosition',[0 0 papersize],...
           'PaperSize',papersize);
    if strcmp(y_label,'RP')
        data(:,2) = -data(:,2);
    end
    age_vector = repmat(0,size(data,1),1);
    for i=1:(length(ages)-1)
        tmp          =(data(:,1)>ages(i)).*(data(:,1)<=ages(i+1));
        tmp_age(:,i) =logical(tmp);
        age_vector   =age_vector+tmp_age(:,i)*i;
        m(i)         =mean(data(tmp_age(:,i),2));
    end
    hold on
    m = m(unique(age_vector));
    for l_i = 1:(length(unique(age_vector)))
        a = 0.6+l_i-1;
        b = 1.4+l_i-1;
        line([a b],[m(l_i) m(l_i)],'Color','k','LineStyle',':','LineWidth',1.2);
    end
    boxplot(data(:,2),age_vector,'Symbol','.','labels',label(unique(age_vector)),'widths',0.8);
    if strcmp(y_label,'RP')
        set(gca,'FontSize',fontsize_axes,'FontName',fonttype,...
         'YTickLabel',{600:-200:0},'YTick',[sort(-(0:200:600))]...
        );
    else
        set(gca,'FontSize',fontsize_axes,'FontName',fonttype);
    end
        xlabel(x_label,'FontSize',fontsize,'FontName',fonttype);
    ylabel(y_label,'FontSize',fontsize,'FontName',fonttype);
    hold off
    set(figure1,'Position',[0 0 1 1]);
    print(figure1,'-dpng','-r400',filename);
end