function [] = seoulWeather ()
close all;
global gui;
gui.fig = figure();
gui.p = plot(0,0);
gui.p.Parent.Postition = [0.2 0.25 0.7 0.7];

gui.buttonGroup = uibottongroup('visible','on','unit','normalized','position',[0 0.4 0.15 0.25],'selectionchangedfcn',{@radioSelect});
gui.r1 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[0.1 0.8 1 0.2],'HandleVisibility','off','string','Farenheit');
gui.r2 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[0.1 0.5 1 0.2],'HandleVisibility','off','string','Celcius');
gui.r3 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[0.1 0.2 1 0.2],'HandleVisibility','off','string','Kelvin');

gui.scrollBar = uicontrol('style','slider','units','normalized','position',[0.2 0.1 0.6 0.05],'value',1,'min',1,'max',12,'sliderstep',[1/11 1/11],'callback',{@scrollbar});

gui.animateButton = uicontrol('style','pushbutton','units','normalized','position',[0.05 0.05 0.1 0.1],'string','Animate','callback',{@animate});
end
function [] = animate(~,~)
global gui;
for i = 1:12
    gui.scrollBar.Value = i;
    scrollbar()
end
end

function [] = scrollbar(~,~)
global gui;
gui.scrollBar.Value = round(gui.scrollBar.Value);
type = gui.buttonGroup.SelectedObject.String;
plotSelectedMonth(type);
end

function [] = radioSelect(~,~)
global gui;
type = gui.buttonGroup.SelectedObject.String;
plotSelectedMonth(type);
end

function [] = plotSelectedMonth(type)
global gui;
data = readmatrix('seoulWeather.csv');
monthListing = data(:,1);
temps = data(:,2);

currentMonth = gui.scrollBar.Value;
monthTemps = temps(monthListing == currentMonth);
if strcmp(type,'Celcius')
    monthTemps = (monthTemps - 32) / 1.8;
elseif strcmp (type,'Kelvin')
    monthTemps = ((monthTemps - 32) / 1.8) + 273.15;
end

gui.p = plot(1:length(monthTemps),monthTemps,'bx');
switch currentMonth
    case 1
        monthString = 'January';
    case 2
        monthString = 'February';
    case 3
        monthString = 'March';
    case 4
        monthString = 'April';
    case 5
        monthString = 'May';
    case 6
        monthString = 'June';
    case 7 
        monthString = 'July';
    case 8
        monthString = 'August';
    case 9 
        monthString = 'September';
    case 10
        monthString = 'October';
    case 11
        monthString = 'November';
    case 12
        monthString = 'December';
end
title(['Temperature for the month of' monthString]);
end