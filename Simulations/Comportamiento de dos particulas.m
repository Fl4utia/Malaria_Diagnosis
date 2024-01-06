clear;
clc;
% Pedir al usuario introducir el valor de las cargas
q1 = input('Introduce el valor de la carga positiva q: ') * 10^-6;
q2 = input('Introduce el valor de la carga negativa q: ') * 10^-6;

xq1 = -2;
yq1 = 0;
xq2 = 2;
yq2 = 0;

% Definir las constantes de Coulomb 
k = 9e9; % N m^2 / C^2

% Definir el rango de posiciones donde se calculará el campo eléctrico
[x,y] = meshgrid(-5:0.1:5);

% Inicializar las componentes del campo eléctrico
[Ex,Ey] = meshgrid(-5:0.1:5);

% Calcular el campo eléctrico en cada punto del rango
for i = 1:length(x)
    for j = 1:length(x)
        r1 = sqrt((x(i, j)-xq1)^2 + (y(i, j)-yq1)^2); % Distancia a la carga 1
        r2 = sqrt((x(i, j)-xq2)^2 + (y(i, j)-yq2)^2); % Distancia a la carga 2
        E1 = k*q1/r1^2; % Magnitud del campo eléctrico de la carga positiva
        E2 = k*q2/r2^2; % Magnitud del campo eléctrico de la carga negativa
        theta1 = atan2((y(i, j)-yq1),(x(i, j)-xq1)); % Ángulo entre el vector y el eje x
        theta2 = atan2((y(i, j)-yq2),(x(i, j)-xq2)); % Ángulo entre el vector y el eje x
        
            Ex(i,j)=E1*cos(theta1) + E2*cos(theta2);
            Ey(i,j)=E1*sin(theta1) + E2*sin(theta2);
       
    end
end

streamslice(x, y, Ex, Ey, 2)
hold on 


% Dibujar los círculos para representar las cargas
% Definir los radios de los círculos
r1 = 0.5;
r2 = 0.5;

% Definir la separación en el eje x
xc = 4;

theta = 0:0.01:2*pi; % Definir el ángulo
x1 = r1*cos(theta)-(xc/2);  % Calcular la coordenada x del primer círculo
y1 = r1*sin(theta);  % Calcular la coordenada y del primer círculo
x2 = r2*cos(theta) + (xc/2); % Calcular la coordenada x del segundo círculo
y2 = r2*sin(theta);      % Calcular la coordenada y del segundo círculo
fill(x1, y1, 'b'); % Rellenar el primer círculo de color azul
text(xq1,yq1,'+','Color','white','FontSize',9);
hold on;           % Mantener el gráfico actual
fill(x2, y2, 'r'); % Rellenar el segundo círculo de color rojo
text(xq2,yq2,'-','Color','white','FontSize',11);
hold on
axis equal;        % Establecer los mismos límites para ambos ejes





