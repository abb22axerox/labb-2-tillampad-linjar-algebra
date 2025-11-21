X = CreateFigure();
%save('minfig.mat',X);

save minifig X;

PlotFigure(load("minifig.mat"));

%save('data.mat', 'A');