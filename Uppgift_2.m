load('STHLMARN2021')
A = [ones(size(Td)), 1:size(Td)];

b  = 

c = A\b;

omega = (2*pi)/(365 * 24);
A0 = c(2) * cos(omega * ts);
A1 = -c(3) * sin(omega * ts);

Tt = @(x) c(1) + A0 * sin(omega*t) + A1 * cos(omega * t);    % anonym funktion för den anpassade modellen

x = [0 1 2]';
y = [6 0 0]';
A = [ones(size(x)) x];
b = y; 
c = A\b                     % minska kvadratlösning till problemet. \ löser i det här fallet normalekvationerna (A'A c = A'b) dvs c = A'*A\(A'*b)
ym = @(x) c(1) + c(2)*x;    % anonym funktion för den anpassade modellen
xplot = 0:0.1:2;
yplot = ym(xplot);          % beräkna modellen för x mellan 0 och 2
plot(x,y,'o',xplot,yplot)   % plotta modellen och data i samma plot
xlabel x, ylabel y
legend('Data','Modell')

x = [1,2,3];
b = [1,-0.6,0.6]';
Amat = [sin(1),sin(2^2),sin(3^2);1,1,1]';

c = Amat\b;

ym = @(x) c(1)*sin(x^2) + c(2);

c0 = c(1);
c1 = c(2);
c = [c0,c1]';
r = Amat * c - b;
resnorm = norm(r);


