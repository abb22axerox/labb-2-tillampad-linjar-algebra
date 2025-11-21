clear all;
close all;

X = load("BatMan.mat").X;

rotmat = [cos(x),-sin(x);sin(x),cos(x)];