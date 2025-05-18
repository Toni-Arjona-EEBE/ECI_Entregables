clear; clc; format long;

La = 3;
Lb = 5;
Lc = 4;
q = 120;
EI = 2*10^5;
EA = 10^7;


K = zeros(3,3);

% ELement 1

L1 = sqrt(La^2 + Lc^2);
L2 = Lb;
a1 = atan(Lc/La);

Keff1 = [EA/L1,0,0,-EA/L1,0,0;
         0,12*EI/L1^3,6*EI/L1^2,0,-12*EI/L1^3,6*EI/L1^2;
         0,6*EI/L1^2,4*EI/L1,0,-6*EI/L1^2,2*EI/L1;
         -EA/L1,0,0,EA/L1,0,0;
         0,-12*EI/L1^3,-6*EI/L1^2,0,12*EI/L1^3,-6*EI/L1^2;
         0,6*EI/L1^2,2*EI/L1,0,-6*EI/L1^2,4*EI/L1];

T1 = [cos(a1),sin(a1),0,0,0,0;
      -sin(a1),cos(a1),0,0,0,0;
      0,0,1,0,0,0;
      0,0,0,cos(a1),-sin(a1),0;
      0,0,0,sin(a1),cos(a1),0;
      0,0,0,0,0,1];

Keff1_Glob = T1*Keff1*transpose(T1);

K(1,1) = K(1,1) + Keff1_Glob(4,4);
K(2,1) = K(2,1) + Keff1_Glob(5,4);
K(3,1) = K(3,1) + Keff1_Glob(6,4);
K(1,2) = K(1,2) + Keff1_Glob(4,5);
K(2,2) = K(2,2) + Keff1_Glob(5,5);
K(3,2) = K(3,2) + Keff1_Glob(6,5);
K(1,3) = K(1,3) + Keff1_Glob(4,6);
K(2,3) = K(2,3) + Keff1_Glob(5,6);
K(3,3) = K(3,3) + Keff1_Glob(6,6);

% ELement 2

Keff2 = [EA/L2,0,0,-EA/L2,0,0;
         0,12*EI/L2^3,6*EI/L2^2,0,-12*EI/L2^3,6*EI/L2^2;
         0,6*EI/L2^2,4*EI/L2,0,-6*EI/L2^2,2*EI/L2;
         -EA/L2,0,0,EA/L2,0,0;
         0,-12*EI/L2^3,-6*EI/L2^2,0,12*EI/L2^3,-6*EI/L2^2;
         0,6*EI/L2^2,2*EI/L2,0,-6*EI/L2^2,4*EI/L2];

K(1,1) = K(1,1) + Keff2(1,1);
K(2,1) = K(2,1) + Keff2(2,1);
K(3,1) = K(3,1) + Keff2(3,1);
K(1,2) = K(1,2) + Keff2(1,2);
K(2,2) = K(2,2) + Keff2(2,2);
K(3,2) = K(3,2) + Keff2(3,2);
K(1,3) = K(1,3) + Keff2(1,3);
K(2,3) = K(2,3) + Keff2(2,3);
K(3,3) = K(3,3) + Keff2(3,3);

% F



F = [0; -q*Lb/2; -q*Lb^2/12];

d = K\F;


% Fuerzas

F1_1 = [-EA/L1,0,0;
    0, -12*EI/L1^3, 6*EI/L1^2;
    0, -6*EI/L1^2, 2*EI/L1];
T_T = [cos(a1), sin(a1),0;-sin(a1),cos(a1),0;0,0,1];
F1_a = F1_1*T_T*d;

F1_2 = [EA/L1,0,0;
    0, 12*EI/L1^3, -6*EI/L1^2;
    0, -6*EI/L1^2, 4*EI/L1];
F1_b = F1_2*T_T*d;


F2_1 = [EA/L1,0,0;
    0, 12*EI/L1^3, 6*EI/L1^2;
    0, 6*EI/L1^2, 4*EI/L1];
F2_a = F2_1*d;

F2_2 = [-EA/L1,0,0;
    0, -12*EI/L1^3, -6*EI/L1^2;
    0, 6*EI/L1^2, 2*EI/L1];
F2_b = F2_2*d;