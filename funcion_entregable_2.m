function Flecha = funcion_entregable_2(a,b,c,d, x, y)
    D = 2.5*10^7*10e3 * 0.25^3 / (12*(1-0.3^2));
        
    Matriz = [ 0               1                b*exp(-pi*b/a)     exp(-pi*b/a)
               b*exp(-pi*b/a)  exp(-pi*b/a)     0               1               
               -2*pi/a         (pi/a)^2         (-2*pi/a + b*(pi/a)^2)*exp(-pi*b/a)     (pi/a)^2*exp(-pi*b/a)
                (-2*pi/a + b*(pi/a)^2)*exp(-pi*b/a)     (pi/a)^2*exp(-pi*b/a)  (-2*pi/a)    (pi/a)^2   ];
    

    Pn = 8*1e3*sin(pi*c/(2*a))/(pi*c*d);
    k = -a^4*Pn/(D*pi^4);
    
    Iguales = transpose([k k 0 0]);
    
    coef = Matriz\Iguales;


    %display(Matriz);
    %display(Iguales);
    %display(coef);

    fFlecha = @(s,t) ( coef(1)*t*exp(-pi*t/a) + coef(2)*exp(-pi*t/a) + coef(3)*(b-t)*exp(-pi*(b-t)/a) + coef(4)*t*exp(-pi*(b-t)/a) + (a^4*Pn)/(D*pi^4) )* sin(pi*s/a);
    
    Flecha = fFlecha(x,y);
end