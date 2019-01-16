syms A B C X Y Z;
Trans=[1 0 0 X;0 1 0 Y;0 0 1 Z;0 0 0 1];
RotX=[1 0 0 0;0 cos(A) -sin(A) 0;0 sin(A) cos(A) 0;0 0 0 1];
RotY=[cos(B) 0 sin(B) 0;0 1 0 0;-sin(B) 0 cos(B) 0;0 0 0 1];
RotZ=[cos(C) -sin(C) 0 0;sin(C) cos(C) 0 0;0 0 1 0;0 0 0 1];
P=RotZ*RotY*RotX

