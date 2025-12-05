clear all; close all;

load('STHLMARN2021')

% plot(length(Td), Td)

%N = length(Td);
N = length(Td);

t = (1:N)';
% ts = (1:length(Td))';
omega = (2*pi)/(365 * 24);

A = [ones(N, 1), t, sin(omega * t), cos(omega * t)];
b  = Td;

c = A\b;

c1 = c(1) % Medellinje/medelvärde
c2 = c(2) % Koefficient för sin(omega*ts)
A0 = c(3) %* cos(omega * ts);
A1 = c(4) %* sin(omega * ts);

%Tt = @(t) c1 + c2 * t + A0 * sin(omega * t) + A1 * cos(omega * t);    % anonym funktion för den anpassade modellen
Tt = @(x) c(1) + c(2) * x + c(3) * sin(omega * x) + c(4) * cos(omega * x);

figure;

plot(t, Tt(t));
c3 = sqrt(A0^2 + A1^2);

fi = atan2(-A1, A0);

ts = fi / omega

ts_dagar = ts / 24