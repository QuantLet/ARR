
[<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/banner.png" alt="Visit QuantNet">](http://quantlet.de/index.php?p=info)

## [<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **ARRpcpgscit** [<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/d3/ia)


```yaml


Name of QuantLet : ARRpcpgscit

Published in : ARR - Academic Rankings Research

Description: 'Creates a parallel coordinates plot for GS citation for the period from 2007 
till 2014 with quartiles'

Keywords : 'plot, correlation, correlation matrix, dependence, multivariate, 
multivariate analysis, visualization, data visualization, analysis, discriptive methods, 
discriptive, graphical representation, descriptive-statistics, parallel coordinates plots, 
quantile'

See also : 'ARRcormer, ARRhexage, ARRhexcit, ARRhexhin, ARRhismer, ARRmosage, 
ARRmoagegr, ARRreghb, ARRboxage, ARRboxgscit, ARRboxhb, ARRpcphb, ARRpcpmer, 
ARRscamer'

Author : Alona Zharova

Submitted : Tue, December 15 2015 by Alona Zharova, Marius Sterling

Datafile : 'ARRdata.dat - The data set contains different researcher (3011 rows) 
of either RePEc (77 columns), Handelsblatt (42 columns) ranking or both and their 
Google Scholar data (16 columns) as well as age and subject fields (2 columns)'

Example : Parrallel coordinate plot

```

![Picture1](ARRpcpgscit.png)


```r



%% Clearing all variables
clear all; clc;
%% Figure settings
fonttype           = 'Helvetica';
fontsize           = 20;
fontsize_axes      = 16;
fontsize_axes_top  = 12;
papersize          = [20 10];
quantile_linewidth = 1.4;
%% Data input
merge        = readtable('ARRdata.dat','Delimiter',';');
%% Data selection (Google Scholar citations over 2007 till 2014)
substrmatch  = @(x,y) ~cellfun(@isempty,strfind(y,x));
findmatching = @(x,y) y(substrmatch(x,y));
x            = sort(findmatching('gs_citation_20',merge.Properties.VariableNames));
x            = x(1:length(x)-1);
TF           = ismissing(merge(:,x)); % selecting all researchers that have a value in all years
z            = table2array(merge(~any(TF,2),x));
%% Standardizing of values
y            = (z-(ones(size(z,1),1)*min(z)))./(ones(size(z,1),1)*(max(z)-min(z)+(max(z)==min(z))));
label        = {'2007','2008','2009','2010','2011','2012','2013','2014'}; % the following line
y=y(~(y(:,4)>0.5&y(:,5)<0.5),:);
%% Creating figure
figure1 = figure('Visible','off','PaperPosition',[0 0 papersize],'PaperSize',papersize);
parallelcoords(y,'linewidth',0.01,'label', label,'Color',[138/255 15/255 20/255])
    set(gca,'FontSize',fontsize_axes,'FontName',fonttype,'YTickLabel',{'0','1'},'YTick',[0 1]);
    ylabel('Citations','FontSize',fontsize,'FontName',fonttype);
    % computing and ploting of quartiles 
    y2=quantile(y,[0.25 0.5 0.75]);
    line(1:length(label),transpose(y2),'linewidth',quantile_linewidth,'Color','k','LineStyle','--');
    box on;
    % creating a second x-axes on top of the plot where the maximum values are noted
    ax1 = gca;
    ax2 = axes('Position',ax1.Position,...
        'FontSize',fontsize_axes_top,...
        'FontName',fonttype,...
        'XAxisLocation','top',...
        'YAxisLocation','right',...
        'XTick',(ax1.XTick-1)/(length(ax1.XTick)-1),...
        'XTickLabel',max(z),...
        'YTick',[],...
        'YTickLabel','',...
        'Color','none');
%% Siving figure
print(figure1,'-dpng','-r400','ARRpcpgscit');        
```
