function MKV
    clear; close all; clc;

    %% Läs in data
    load('STHLMARN2021');      % antar att vektorn Td finns
    Td = Td(:);                % säkerställ kolonnvektor
    N  = length(Td);

    % Tidsvektor i timmar från 1 jan 2009 kl 00:00
    t = (0:N-1)';              % [h]

    %% === Uppgift 2b: Anpassa modellen (2) till timdata ===
    % Modell (2): T(t) = c1 + c2*t + A0*sin(ωt) + A1*cos(ωt)
    omega_h = 2*pi/(365*24);   % [rad/h], ett år

    A = [ones(N,1), t, sin(omega_h*t), cos(omega_h*t)];
    c = A \ Td;                % minstakvadratlösning

    c1 = c(1);
    c2 = c(2);
    A0 = c(3);
    A1 = c(4);

    % Amplitud och fasförskjutning (modell (1): c3, ts)
    c3  = sqrt(A0^2 + A1^2);
    phi = atan2(-A1, A0);      % fasvinkel φ = ω * ts
    ts  = phi / omega_h;       % [h]
    ts_dagar = ts / 24;        % [dygn]

    % Modellvärden för timdata
    Tmod_h = c1 + c2*t + A0*sin(omega_h*t) + A1*cos(omega_h*t);

    % Plotta timdata + modell (2b)
    figure;
    plot(t, Td, '.', 'DisplayName', 'Mätdata (tim)');
    hold on;
    plot(t, Tmod_h, 'LineWidth', 2, 'DisplayName', 'Modell (tim)');
    xlabel('tid t [h]');
    ylabel('temperatur T [°C]');
    legend('Location','best');
    grid on;
    title('Uppgift 2b: Anpassning till timdata');

    fprintf('--- Uppgift 2b ---\n');
    fprintf('c1 = %.3f\n', c1);
    fprintf('c2 = %.6g (°C per timme)\n', c2);
    fprintf('c3 = %.3f (amplitud)\n', c3);
    fprintf('ts = %.1f h (≈ %.1f dygn)\n\n', ts, ts_dagar);

    %% === Uppgift 2c: Normen av residualen för timdata ===
    r_h = Td - Tmod_h;
    resnorm_h = norm(r_h);     % ||Td - Tmod||_2

    fprintf('--- Uppgift 2c ---\n');
    fprintf('Residualnorm timdata: ||Td - Tmod||_2 = %.3f\n\n', resnorm_h);

    %% === Uppgift 2d: Långsiktig trend 2009–2021 ===
    % c2 är lutningen i °C per timme.
    % Omvandla till °C per år för tolkning:
    grad_per_ar = c2 * 24 * 365;

    fprintf('--- Uppgift 2d ---\n');
    fprintf('Trend: %.4f °C per år\n', grad_per_ar);
    fprintf('Positivt värde => långsiktig ökning, negativt => minskning.\n\n');

    %% === Uppgift 2e: Anpassa modellen till dygnsmedeltemperatur ===
    omega_d = 2*pi/365;        % [rad/dygn]

    % Räkna ut dygnsmedeltemperaturer
    % N bör vara delbart med 24
    Td_mat = reshape(Td, 24, []);       % 24 x antal_dygn
    Td_dygn = mean(Td_mat, 1)';         % (antal_dygn x 1)
    Nd = length(Td_dygn);

    t_dygn = (0:Nd-1)';                 % t i dygn

    % Designmatris för dygnsmedeldata
    A_d = [ones(Nd,1), t_dygn, sin(omega_d*t_dygn), cos(omega_d*t_dygn)];
    c_d = A_d \ Td_dygn;

    c1_d = c_d(1);
    c2_d = c_d(2);
    A0_d = c_d(3);
    A1_d = c_d(4);

    c3_d  = sqrt(A0_d^2 + A1_d^2);
    phi_d = atan2(-A1_d, A0_d);
    ts_d  = phi_d / omega_d;          % [dygn]

    % Modellvärden för dygnsdata
    Tmod_d = c1_d + c2_d*t_dygn + A0_d*sin(omega_d*t_dygn) + A1_d*cos(omega_d*t_dygn);

    % Plotta dygnsmedel + modell (2e)
    figure;
    plot(t_dygn, Td_dygn, '.', 'DisplayName', 'Dygnsmedel');
    hold on;
    plot(t_dygn, Tmod_d, 'LineWidth', 2, 'DisplayName', 'Modell (dygn)');
    xlabel('tid [dygn]');
    ylabel('temperatur T [°C]');
    legend('Location','best');
    grid on;
    title('Uppgift 2e: Anpassning till dygnsmedeltemperatur');

    % Residualnorm för dygnsdata
    r_d = Td_dygn - Tmod_d;
    resnorm_d = norm(r_d);

    fprintf('--- Uppgift 2e ---\n');
    fprintf('c1_d = %.3f\n', c1_d);
    fprintf('c2_d = %.6g (°C per dygn)\n', c2_d);
    fprintf('c3_d = %.3f\n', c3_d);
    fprintf('ts_d = %.1f dygn\n', ts_d);
    fprintf('Residualnorm dygnsmedel: ||Td - Tmod||_2 = %.3f\n', resnorm_d);
    fprintf('Jämför residualnormen här med den i 2c.\n');
end