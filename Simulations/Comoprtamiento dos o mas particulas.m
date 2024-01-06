clear;
clc;

% Pedir al usuario introducir el valor de las cargas
q = input('Introduce el valor de la carga (en microculombios): ') * 10^-6;

% Pedir al usuario introducir las longitudes de los arreglos
L1 = input('Introduce la longitud del arreglo 1: ');
L2 = input('Introduce la longitud del arreglo 2: ');

% Calcular la densidad de carga lineal uniforme para cada arreglo
lambdaL1 = q / L1;
lambdaL2 = -q / L2;

% Crear los arreglos de cargas
d1 = L1 / 4; %distancia entre las cargas del arreglo 1
d2 = L2 / 4; %distancia entre las cargas del arreglo 2

xq1 = -2; 
yq1 = -2*d1:d1:2*d1; %Sumar 2+1+2 para tener 5 cargas para tener 10 cargas sumar 5+1+4
xq2 = 2;
yq2 = -2 * d2:d2:2*d2;

% Definir las constantes de Coulomb 
k = 9e9; % N m^2 / C^2

% Definir el rango de posiciones donde se calculará el campo eléctrico
[x,y] = meshgrid(-5:0.1:5);

% Inicializar las componentes del campo eléctrico
[Ex,Ey] = meshgrid(-5:0.1:5);

% Calcular el campo eléctrico en cada punto del rango
for i = 1:length(x)
    for j = 1:length(x)
        Ex(i,j) = 0;
        Ey(i,j) = 0;
        for l = 1:length(yq1)
            r1 = sqrt((x(i, j)-xq1)^2 + (y(i, j)-yq1(l))^2); % Distancia a la carga 1
            E1 = k*lambdaL1/r1; % Magnitud del campo eléctrico de la carga positiva
            theta1 = atan2((y(i, j)-yq1(l)),(x(i, j)-xq1)); % Ángulo entre el vector y el eje x

            r2 = sqrt((x(i, j)-xq2)^2 + (y(i, j)-yq2(l))^2); % Distancia a la carga 2
            E2 = k*lambdaL2/r2; % Magnitud del campo eléctrico de la carga negativa
            theta2 = atan2((y(i, j)-yq2(l)),(x(i, j)-xq2)); % Ángulo entre el vector y el eje x

            Ex(i,j)=Ex(i,j) + E1*cos(theta1) + E2*cos(theta2);
            Ey(i,j)=Ey(i,j) + E1*sin(theta1) + E2*sin(theta2);
        end
    end
end
streamslice(x, y, Ex, Ey, 2)
hold on

rectangle('Position',[0 0 2 4],'Curvature',0.2)
hold on