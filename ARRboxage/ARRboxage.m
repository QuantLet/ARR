%% Clearing all variables
clear all; clc;
%% Image settings
fonttype      = 'Helvetica';
fontsize      = 24;
fontsize_axes = 12;
papersize     = [15 10];
%% Data input
subage   = readtable('ARRdatage.csv','Delimiter',';');
%% Data selection
subagehb = table2array(subage(:, 1:2));
subagerp = table2array(subage(:, 3:4));
subagegs = table2array(subage(:, 5:6));
%% Data 
ages     = [0 35 40 45 50 55 60 65 70 999];
label    = {'<36' '36-40' '41-45' '46-50' '51-55' '56-60' '61-65' '66-70' '70>'};
%% Creating figures with the function
ARRboxage_fun(subagehb,papersize,label,fontsize,fontsize_axes,fonttype,'ARRboxage_HB','Age','HB',ages)
ARRboxage_fun(subagerp,papersize,label,fontsize,fontsize_axes,fonttype,'ARRboxage_RP','Age','RP',ages)
ARRboxage_fun(subagegs,papersize,label,fontsize,fontsize_axes,fonttype,'ARRboxage_GS','Age','GS',ages)
