clear all;
close all;

X = CreateFigure();

save minifig X;

PlotFigure(load("minifig.mat").X);