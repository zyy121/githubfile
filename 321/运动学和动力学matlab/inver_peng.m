clear;
clc;
th1=0;
th2=0;
th3=0;
th4=0;
th5=0;
th6=0;
%D-H parameter
tt1=th1;
tt2=th2+90;
tt3=th3;
tt4=th4-90;
tt5=th5;
tt6=th6;
%-------------------------
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
%transition matrix
A01=[
cosd(tt1)	-cosd(al1)*sind(tt1)	sind(al1)*sind(tt1)		aa1*cosd(tt1);
sind(tt1) 	cosd(al1)*cosd(tt1) 	-sind(al1)*cosd(tt1) 	aa1*sind(tt1);
0			sind(al1)				cosd(al1)				dd1;
0			0						0						1
];
A12=[
cosd(tt2)	-cosd(al2)*sind(tt2)	sind(al2)*sind(tt2)		aa2*cosd(tt2);
sind(tt2) 	cosd(al2)*cosd(tt2) 	-sind(al2)*cosd(tt2) 	aa2*sind(tt2);
0			sind(al2)				cosd(al2)				dd2;
0			0						0						1
];
A23=[
cosd(tt3)	-cosd(al3)*sind(tt3)	sind(al3)*sind(tt3)		aa3*cosd(tt3);
sind(tt3) 	cosd(al3)*cosd(tt3) 	-sind(al3)*cosd(tt3) 	aa3*sind(tt3);
0			sind(al3)				cosd(al3)				dd3;
0			0						0						1
];
A34=[
cosd(tt4)	-cosd(al4)*sind(tt4)	sind(al4)*sind(tt4)		aa4*cosd(tt4);
sind(tt4) 	cosd(al4)*cosd(tt4) 	-sind(al4)*cosd(tt4) 	aa4*sind(tt4);
0			sind(al4)				cosd(al4)				dd4;
0			0						0						1
];
A45=[
cosd(tt5)	-cosd(al5)*sind(tt5)	sind(al5)*sind(tt5)		aa5*cosd(tt5);
sind(tt5) 	cosd(al5)*cosd(tt5) 	-sind(al5)*cosd(tt5) 	aa5*sind(tt5);
0			sind(al5)				cosd(al5)				dd5;
0			0						0						1
];
A56=[
cosd(tt6)	-cosd(al6)*sind(tt6)	sind(al6)*sind(tt6)		aa6*cosd(tt6);
sind(tt6) 	cosd(al6)*cosd(tt6) 	-sind(al6)*cosd(tt6) 	aa6*sind(tt6);
0			sind(al6)				cosd(al6)				dd6;
0			0						0						1
];
%-------------------------------------------------------------------------
F=A01*A12*A23*A34*A45*A56;
%covert matrix to Euler
% _           _ 
%| nx sx ax px |   
%| ny sy ay py |   
%| nz sz az pz | = F = RotZ*RotY*RotX
%|_0  0  0  1 _|   
px=F(1,4);
py=F(2,4);
pz=F(3,4);
rc=atan2d(F(2,1),F(1,1));
ra=atan2d(F(1,3)*sind(rc)-F(2,3)*cosd(rc),F(2,2)*cosd(rc)-F(1,2)*sind(rc));
rb=atan2d(-F(3,1),F(1,1)*cosd(rc)+F(2,1)*sind(rc));
%transition matrix
I=[
cosd(rb)*cosd(rc)	cosd(rc)*sind(ra)*sind(rb) - cosd(ra)*sind(rc)	sind(ra)*sind(rc) + cosd(ra)*cosd(rc)*sind(rb)  px;
cosd(rb)*sind(rc)	cosd(ra)*cosd(rc) + sind(ra)*sind(rb)*sind(rc)	cosd(ra)*sind(rb)*sind(rc) - cosd(rc)*sind(ra)  py;
-sind(rb)	    	cosd(rb)*sind(ra)	                   			cosd(ra)*cosd(rb)  						  	 	pz;
0	            0	                                	  			0								   				1
]
nx=I(1,1);
ny=I(2,1);
nz=I(3,1);
sx=I(1,2);
sy=I(2,2);
sz=I(3,2);
ax=I(1,3);
ay=I(2,3);
az=I(3,3);
%calculate joint angle
n1=py-ay*dd6;
m1=px-ax*dd6;
theta1=asind((dd2-dd3+dd4)/sqrt(n1*n1+m1*m1))+atan2d(n1,m1)