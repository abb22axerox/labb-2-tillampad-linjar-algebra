clear all; close all;

load('STHLMARN2021')

N = length(Td);

t = (1:N)';

omega = (2*pi)/(365 * 24);

A = [ones(N, 1), t, sin(omega * t), cos(omega * t)];
b  = Td;

c = A\b;

c1 = c(1); % Medellinje/medelvärde
c2 = c(2); % Koefficient för sin(omega*ts)
A0 = c(3); %* cos(omega * ts);
A1 = c(4); %* sin(omega * ts);

Tt = @(x) c(1) + c(2) * x + c(3) * sin(omega * x) + c(4) * cos(omega * x);

figure;

% Uppgift b)
plot(t, Tt(t));
hold on;
c3 = sqrt(A0^2 + A1^2);

fi = atan2(-A1, A0);

ts = fi / omega

ts_dagar = ts / 24


% Uppgift c)
Tmod = Tt(t);

residualen = abs(Td - Tmod);
residualens_norm = norm(residualen, 2)

% Uppgift d)
% Ja, det är en vag ökning över tid.


% Uppgift e)
dygnsmedelstemperatur = [];
for i = 1:((length(Td)/24)-1)
    dygnsmedelstemperatur = [dygnsmedelstemperatur, mean(Td((i*24):((i+1)*24)))];
end

dygnsmedelstemperatur = dygnsmedelstemperatur';

omega2 = (2*pi)/365;

t2 = (1:(length(dygnsmedelstemperatur)))';

A2 = [ones(length(dygnsmedelstemperatur), 1), t2, sin(omega2 * t2), cos(omega2 * t2)];
b2 = dygnsmedelstemperatur;

c_2 = A2\b2

c_21 = c_2(1); % Medellinje/medelvärde
c_22 = c_2(2); % Koefficient för sin(omega*ts)
A_0 = c_2(3); %* cos(omega * ts);
A_1 = c_2(4); %* sin(omega * ts);

Tt2 = @(x) c_21 + c_22 * x + A_0 * sin(omega2 * x) + A_1 * cos(omega2 * x);

plot(t2*24, Tt2(t2))
hold off;

% Det är tillochmed delbart
% 113952 | 24

% Residualsberäkning 2e)
Tmod2 = Tt2(t2);

residualen2 = abs(dygnsmedelstemperatur - Tmod2);
residualens_norm2 = norm(residualen2, 2) % Blev lång, större fel