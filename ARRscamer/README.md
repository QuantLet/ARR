
[<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/banner.png" alt="Visit QuantNet">](http://quantlet.de/index.php?p=info)

## [<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **ARRscamer** [<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/d3/ia)


```yaml





Name of QuantLet : ARRscamer

Published in : ARR - Academic Rankings Research

Description: 'Creates scatterplots of the main scores of Handelsblatt (HB), RePEc (RP) 
and Google Scholar (GS) rankings'

Keywords : 'plot, correlation, dependence, multivariate, multivariate analysis, visualization, 
data visualization, analysis, discriptive methods, discriptive, graphical representation, 
scatterplot, plot, distribution'

See also : 'ARRboxage, ARRboxgscit, ARRboxhb, ARRcormer, ARRdenmer2d, ARRdenmer3d, ARRhexage, ARRhexcit, 
ARRhexhin, ARRhismer, ARRmosage, ARRmosagegr, ARRmossub, ARRpcpgscit, ARRpcphb, ARRpcpmer, 
ARRpcprp, ARRqrqqhb, ARRscaage'

Author : Alona Zharova

Submitted : Tue, December 15 2015 by Alona Zharova, Marius Sterling

Datafile : 'ARRdata.dat - The data set contains different researcher (3011 rows) 
of either RePEc (77 columns), Handelsblatt (42 columns) ranking or both and their 
Google Scholar data (16 columns) as well as age and subject fields (2 columns)'

Example : Scatterplot

```

![Picture1](ARRscamer.png)

```r




%% Clearing all variables
clear all; clc;
%% Figure settings
fonttype      = 'Helvetica';
fontsize      = 24;
fontsize_axes = 14;
papersize     = [30 9];
cex           = 100;
az_gray       = [100 100 100]/255; % color of points in scatterplot
%% Data input
merge        = readtable('ARRdata.dat','Delimiter',';');
%% Function for data selection
substrmatch  = @(x,y) ~cellfun(@isempty,strfind(y,x));
findmatching = @(x,y) y(substrmatch(x,y));
%% Data selection (getting all researchers with HB commonscores, RP score and GS citations
x1 = substrmatch('hb_comonscores',merge.Properties.VariableNames);
x2 = substrmatch('rp_score',merge.Properties.VariableNames);
x3 = substrmatch('gs_total_cites',merge.Properties.VariableNames);
x  = x1|x2|x3;
TF = ismissing(merge(:,x));
z1 = table2array(merge(~any(TF,2),{'hb_comonscores','rp_score','gs_total_cites'}));
HB = z1(:, 1);
RP = z1(:, 2);
GS = z1(:, 3);
%% Creating figure
figure1 = figure('Visible','off','PaperPosition',[0 0 papersize],'PaperSize',papersize);
    hold on
    % creating image of 3 plot in a row
    subplot(1, 3, 1),
    % scatterplot
    scatter(HB,GS,cex,az_gray,'.');
        % setting labels
        xlabel('HB','FontSize',fontsize,'FontName',fonttype);
        ylabel('GS','FontSize',fontsize,'FontName',fonttype);
        set(gca,'FontSize',fontsize_axes,'FontName',fonttype);
        % setting length of axis same
        axis square;
        % setting a box around the plot
        box on;
    subplot(1, 3, 2),
    scatter(GS, RP,cex,az_gray,'.');
        xlabel('GS','FontSize',fontsize,'FontName',fonttype);
        ylabel('RP','FontSize',fontsize,'FontName',fonttype);
        set(gca,'FontSize',fontsize_axes,'FontName',fonttype);
        axis square;
        box on;
    subplot(1, 3, 3),
    scatter(HB, RP,cex,az_gray,'.');
        xlabel('HB','FontSize',fontsize,'FontName',fonttype);
        ylabel('RP','FontSize',fontsize,'FontName',fonttype);
        set(gca,'FontSize',fontsize_axes,'FontName',fonttype);
        axis square;
        box on;
    hold off    
%% Saving figure
set(figure1,'Position',[0 0 1 1]);
print(figure1,'-dpng','-r400','ARRscamer');

```
