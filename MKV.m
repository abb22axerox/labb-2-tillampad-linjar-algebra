load('STHLMARN2021')

%N = length(Td);
N = length(Td);

t = (1:N)';
ts = (1:length(Td))';
omega = (2*pi)/(365 * 24);

A = [ones(N, 1),t,sin(omega * t), cos(omega * t)];
b  = Td;

c = A\b;

c1 = c(1) % Medellinje/medelvärde
c2 = c(2) % Koefficient för sin(omega*t)
A0 = c(3) * cos(omega * ts)
A1 = -c(3) * sin(omega * ts)

Tt = @(x) c(1) + c(2) * t + A0 * sin(omega * t) + A1 * cos(omega * t);    % anonym funktion för den anpassade modellen

plot(t, Tt)

% t_plot = linspace(ts(1), ts(end), 1000)';

% % Beräkna de anpassade värdena
% T_fit = Tt(t_plot);

% % Plotta resultatet
% figure;
% plot(ts, Td, 'b.', 'DisplayName', 'Uppmätta Data');
% hold on;
% plot(t_plot, T_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'Anpassad Sinusmodell');
% xlabel('Tid (timmar)');
% ylabel('Temperatur Td');
% title('Minsta Kvadratanpassning av Sinusmodell');
% legend('show');
% grid on;