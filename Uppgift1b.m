clear all;
close all;

X = load("BatMan.mat").X

x = pi/4;

rotmat = [cos(x),-sin(x);sin(x),cos(x)];

PlotFigure(rotmat * X)