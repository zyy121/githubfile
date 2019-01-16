%variable
syms nx ny nz real;
syms sx sy sz real;
syms ax ay az real;
syms px py pz real;
%D-H parameter
syms tt1 tt2 tt3 tt4 tt5 tt6 real;
%syms dd1 dd2 dd3 dd4 dd5 dd6 real;
%syms aa2 aa3 real;

dd1=142.35;
dd2=144;
dd3=121;
dd4=113;
dd5=113;
dd6=100.5;
%-------------------------
aa1=0;
aa2=385;
aa3=352;
aa4=0;
aa5=0;
aa6=0;
%-------------------------
al1=90;
al2=180;
al3=180;
al4=-90;
al5=90;
al6=0;
%matrixs:
T=[nx sx ax px;ny sy ay py;nz sz az pz;0 0 0 1]
A01=[
cos(tt1)	-cosd(al1)*sin(tt1)	sind(al1)*sin(tt1)		aa1*cos(tt1);
sin(tt1) 	cosd(al1)*cos(tt1) 	-sind(al1)*cos(tt1) 	aa1*sin(tt1);
0			sind(al1)				cosd(al1)				dd1;
0			0						0						1
]
A12=[
cos(tt2)	-cosd(al2)*sin(tt2)	sind(al2)*sin(tt2)		aa2*cos(tt2);
sin(tt2) 	cosd(al2)*cos(tt2) 	-sind(al2)*cos(tt2) 	aa2*sin(tt2);
0			sind(al2)				cosd(al2)				dd2;
0			0						0						1
]
A23=[
cos(tt3)	-cosd(al3)*sin(tt3)	sind(al3)*sin(tt3)		aa3*cos(tt3);
sin(tt3) 	cosd(al3)*cos(tt3) 	-sind(al3)*cos(tt3) 	aa3*sin(tt3);
0			sind(al3)				cosd(al3)				dd3;
0			0						0						1
]
A34=[
cos(tt4)	-cosd(al4)*sin(tt4)	sind(al4)*sin(tt4)		aa4*cos(tt4);
sin(tt4) 	cosd(al4)*cos(tt4) 	-sind(al4)*cos(tt4) 	aa4*sin(tt4);
0			sind(al4)				cosd(al4)				dd4;
0			0						0						1
]
A45=[
cos(tt5)	-cosd(al5)*sin(tt5)	sind(al5)*sin(tt5)		aa5*cos(tt5);
sin(tt5) 	cosd(al5)*cos(tt5) 	-sind(al5)*cos(tt5) 	aa5*sin(tt5);
0			sind(al5)				cosd(al5)				dd5;
0			0						0						1
]
A56=[
cos(tt6)	-cosd(al6)*sin(tt6)	sind(al6)*sin(tt6)		aa6*cos(tt6);
sin(tt6) 	cosd(al6)*cos(tt6) 	-sind(al6)*cos(tt6) 	aa6*sin(tt6);
0			sind(al6)				cosd(al6)				dd6;
0			0						0						1
]

L=A01*A12*A23*A34*A45*A56
