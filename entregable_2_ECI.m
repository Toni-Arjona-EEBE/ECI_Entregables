clear
format long
clc

a = 10;
b = 5;

c = a/300;
d = b/300;

Flecha = funcion_entregable_2(a,b,c,d,  2/3*a  ,  b/2  );

fprintf("+----------- Método de Levy ------------+\n");
fprintf("| [ c = %.8f | d = %.8f ]\t|\n", c, d);
fprintf("| W(2a/3,b/2) = %.8f m\t\t\t|\n", Flecha);
fprintf("| W(2a/3,b/2) = %.8f mm\t\t\t|\n", Flecha*10e3);
fprintf("+---------------------------------------+\n");


