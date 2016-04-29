
function ARRboxfun(z2,papersize,label,fontsize,fontsize_axes,fonttype,filename,x_label,y_label)
% creating the figure
figure1 = figure('Visible','off','PaperPosition',[0 0 papersize],'PaperSize',papersize);
   % calculating the means
    m=mean(z2);
    hold on;
    % plotting the means
    for l_i = 1:size(z2,2)
        a   = 0.6+l_i-1;
        b   = 1.4+l_i-1;
        line([a b],[m(l_i) m(l_i)],'Color','k','LineStyle',':','LineWidth',1.2);
    end
    % boxplots
    boxplot([z2],'Symbol','.','labels',label,'widths',0.8)
    % setting labels
    set(gca,'FontSize',fontsize_axes,'FontName',fonttype);
    xlabel(x_label,'FontSize',fontsize,'FontName',fonttype);
    ylabel(y_label,'FontSize',fontsize,'FontName',fonttype);
    hold off
    set(figure1,'Position',[0 0 1 1]);
% creating the image (png)
print(figure1,'-dpng','-r400',filename);
end