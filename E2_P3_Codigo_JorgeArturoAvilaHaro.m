% ------------------------------------------------------------
% MÉTODO DE LÉVY - RESOLUCIÓN DE PLACA SIMPLEMENTE APOYADA
% CARGA PUNTUAL APROXIMADA COMO RECTÁNGULO PEQUEÑO
% MODO n = 1 - Forma homogénea con base de exponenciales
% ------------------------------------------------------------
close; clear; clc;
% --------------------------
% PARÁMETROS DEL PROBLEMA
% --------------------------
a = 10;           % Largo de la placa (m)
b = 5;            % Alto de la placa (m)
h = 0.25;         % Espesor de la placa (m)
E = 2.5e7 * 1e3;  % Módulo de Young (kN/m² convertido a N/m²)
nu = 0.3;         % Coeficiente de Poisson
P = 4 * 1e3;      % Carga puntual total (kN convertido a N)
n = 1;            % Modo de análisis (n = 1)
x0 = (2/3)*a;     % Posición horizontal de la carga
y0 = 0.5*b;       % Posición vertical de la carga

% --------------------------
% PARÁMETROS DERIVADOS
% --------------------------
alpha = n*pi/a;                        % Frecuencia senoidal (por simplicidad al sustituir)
D = (E*h^3) / (12*(1 - nu^2));         % Rigidez flexional de la placa

% --------------------------
% TAMAÑO DEL RECTÁNGULO DE CARGA (APROXIMACIÓN DE CARGA PUNTUAL)
% --------------------------
c = a/2000 ;                           % Ancho de rectángulo (m)
d = b/2000 ;                           % Alto de rectángulo (m)

% --------------------------
% PROYECCIÓN DE LA CARGA PUNTUAL - Pn
% --------------------------
Pn = (4*P)/(n*pi*c*d) * sin(n*pi*c/(2*a)) * cos(n*pi*x0/a);

% --------------------------
% SOLUCIÓN PARTICULAR
% --------------------------
W_p = Pn / (D * alpha^4);  % Parte particular de la solución

% --------------------------
% CONSTRUCCIÓN DE LA SOLUCIÓN HOMOGÉNEA
% --------------------------
syms C1 C2 C3 C4 y          % Definimos de forma simbólica algunas variables para operar

% Parte homogénea W_h(y)
W_h = C1*y*exp(-alpha*y) + C2*exp(-alpha*y) + ...
      C3*(b - y)*exp(-alpha*(b - y)) + C4*exp(-alpha*(b - y));

% --------------------------
% SOLUCIÓN TOTAL EN y: W(y) = W_p + W_h(y)
W = W_p + W_h;
% --------------------------

% --------------------------
% CONDICIONES DE BORDE EN Y (simplemente apoyado)
% Flecha nula:      W(0) = 0, W(b) = 0
% Momento nulo:     W''(0) = 0, W''(b) = 0 (versión simplificada)
% --------------------------

% Segunda derivada de W respecto a y (para momento flector nulo)
W2 = diff(W, y, 2);

eq1 = subs(W, y, 0) == 0; % Flecha nula evaluada en y=0
eq2 = subs(W2, y, 0) == 0; % Momento flector nulo evaluado en y=0
eq3 = subs(W, y, b) == 0; % Flecha nula evaluada en y=b
eq4 = subs(W2, y, b) == 0; % Momento flector nulo evaluado en y=b

% --------------------------
% RESOLUCIÓN DEL SISTEMA LINEAL
% --------------------------
S = solve([eq1, eq2, eq3, eq4], [C1, C2, C3, C4]);

% --------------------------
% EVALUACIÓN DE LA FLECHA TOTAL EN (x0, y0)
% --------------------------
W_total = simplify(W);  % Expresión final en y (forma simbólica)
W_eval = double(subs(W_total, ...
            [C1, C2, C3, C4, y], ...
            [S.C1, S.C2, S.C3, S.C4, y0]));

% Flecha total en (x0, y0)
w = W_eval * sin(n*pi*x0/a); % (forma numérica)

% --------------------------
% RESULTADO FINAL
% --------------------------
disp('---------------------------------------');
disp(['c= ', num2str(c), ' m']);
disp(['d= ', num2str(d), ' m']);
disp('---------------------------------------');
disp('---------------------------------------');
disp(['Flecha en (x0, y0) = ', num2str(w), ' m']);
disp('---------------------------------------');

% --------------------------
% EVALUACIÓN DE LA FLECHA EN TODA LA PLACA (X, Y)
% --------------------------
% Crear malla de puntos (X, Y)
%Nx = 100; Ny = 50;  % resolución
%x_vals = linspace(0, a, Nx);
%y_vals = linspace(0, b, Ny);
%[X, Y] = meshgrid(x_vals, y_vals);

% Reemplazar los coeficientes ya conocidos
%W_total_y = subs(W, [C1, C2, C3, C4], [S.C1, S.C2, S.C3, S.C4]);

% Evaluar la parte vertical W(y) y parte senoidal en x
%W_y_numeric = double(subs(W_total_y, y, Y));
%W_x = sin(n*pi*X/a);

% Flecha total w(x,y)
%W_xy = W_y_numeric .* W_x;

% --------------------------
% GRÁFICO DE LA SUPERFICIE 3D
% --------------------------

%figure;
%surf(X, Y, W_xy, 'EdgeColor', 'none'); % superficie suave
%xlabel('x [m]');
%ylabel('y [m]');
%zlabel('w(x, y) [m]');
%title('Flecha de la placa por método de Lévy (modo n = 1)');
%colormap jet; colorbar;
%view(45, 30);
%axis tight;