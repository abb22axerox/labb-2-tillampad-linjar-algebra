function [ X ] = CreateFigure;
% CREATEFIGURE Skapar ett 2D objekt med hjalp av punkter som definerar
% objektets kontur. Markera punkterna med vanster-klick. Markera sista 
% punkten med hoger-klick. Punkterna sammanbinds i den ordning de 
% markerats. Den sista punkten binds även ihop med den första.
%
% Anropa funktionen med X = CreateFigure;
%
% X kommer att innehalla koordinaterna for de punkter som definierar
% figuren. I X(1,:) finns x-koordinaterna lagrade. I X(2,:) finns
% y-koordinaterna lagrade.


X = [];
n = 1;

disp(' ')
disp('Definiera figurens kontur genom att markera punkter i figurfonstret.')
disp(' ')
disp('Punkterna kommer att sammanfogas i den ordning de markeras.')
disp(' ') 
disp('Vanster-klicka for att markera en punkt på konturen.')
disp('Hoger-klicka for att markera den sista punkten.')
disp(' ')
input('Tryck pa valfri tangent for att borja rita din figur.');
figure(3000)
clf
axis([-20 20 -20 20])
hold on; grid minor;
but = 1;
while but == 1
    [xi,yi,but] = ginput(1);
    plot(xi,yi,'bo','LineWidth',3,'MarkerSize',4)
    X(:,n) = [xi; yi];
    n = n+1;
end
grid off
xs=[X(1,:) X(1,1)];
ys=[X(2,:) X(2,1)];
plot(xs,ys)

end

