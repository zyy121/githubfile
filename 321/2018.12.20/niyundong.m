clc;
clear;

dd1=142.35;
dd2=144;
dd3=121;
dd4=113;
dd5=113;
dd6=100.5;

aa1=0;
aa2=385;
aa3=352;
aa4=0;
aa5=0;
aa6=0;

al1=90;
al2=180;
al3=180;
al4=-90;
al5=90;
al6=0;

j=0;
tem1=20;
tem2=120;
tem3=30;
tem4=-50;
tem5=40;
tem6=140;
th2340=tem2-tem3+tem4;
for i=0:100
px=-130;
py=-273;
pz=956+i;
ra=-65;
rb=-6.6;
rc=-130;


%transition matrix
I=[
cosd(rb)*cosd(rc)	cosd(rc)*sind(ra)*sind(rb) - cosd(ra)*sind(rc)	sind(ra)*sind(rc) + cosd(ra)*cosd(rc)*sind(rb)  px;
cosd(rb)*sind(rc)	cosd(ra)*cosd(rc) + sind(ra)*sind(rb)*sind(rc)	cosd(ra)*sind(rb)*sind(rc) - cosd(rc)*sind(ra)  py;
-sind(rb)	    	cosd(rb)*sind(ra)	                   			cosd(ra)*cosd(rb)  						  	 	pz;
0	            0	                                	  			0								   				1
];
%calculate joint angle
ay1=py-dd6*I(2,3);
ax1=dd6*I(1,3)-px;
C_1=dd3-dd2-dd4;
r_1=sqrt((ax1)*(ax1)+(ay1)*(ay1));
%%反解角1
throu=atan2d(ay1,ax1);
th11=atan2d(C_1,sqrt(abs(r_1*r_1-C_1*C_1)))-throu;
th12=atan2d(C_1,-sqrt(abs(r_1*r_1-C_1*C_1)))-throu;
%if th11 不在范围
if th11>180
th11=th11-360;
end
if th11<=-180
th11=th11+360;
end
%if th12 不在范围
if th12>180
th12=th12-360;
end
if th12<=-180
th12=th12+360;
end
%选值
if abs(th11-tem1)<=abs(th12-tem1)
theta1=th11;
else
theta1=th12;
end
%%反解角5
th51=atan2d(sqrt(1-(cosd(theta1)*I(2,3)-sind(theta1)*I(1,3))*(cosd(theta1)*I(2,3)-sind(theta1)*I(1,3))),-cosd(theta1)*I(2,3)+sind(theta1)*I(1,3));
th52=atan2d(-sqrt(1-(cosd(theta1)*I(2,3)-sind(theta1)*I(1,3))*(cosd(theta1)*I(2,3)-sind(theta1)*I(1,3))),-cosd(theta1)*I(2,3)+sind(theta1)*I(1,3));
%if th51 不在范围
if th51>180
th51=th51-360;
end
if th51<=-180
th51=th51+360;
end
%if th52 不在范围
if th52>180
th52=th52-360;
end
if th52<=-180
th52=th52+360;
end
%选值
if abs(th51-tem5)<=abs(th52-tem5)
theta5=th51;
else
theta5=th52;
end
%%反解角6
th61=atan2d(sind(theta1)*I(1,2)-cosd(theta1)*I(2,2),cosd(theta1)*I(2,1)-sind(theta1)*I(1,1));
th62=th61+180;
%if theta6 不在范围
if th61>180
th61=th61-360;
end
if th61<=-180
th61=th61+360;
end
if th62>180
th62=th62-360;
end
if th62<=-180
th62=th62+360;
end
%选值
if abs(th61-tem6)<=abs(th62-tem6)
theta6=th61;
else
theta6=th62;
end
%反解角2-角3+角4 ??
th2341=atan2d(I(3,3),(cosd(theta1)*I(1,3)+sind(theta1)*I(2,3)));
th2342=th2341+180;
if th2341>180
th2341=th2341-360;
end
if th2341<-180
th2341=th2341+360;
end
if th2342>180
th2342=th2342-360;
end
if th2342<-180
th2342=th2342+360;
end
%选解
if th2340>180
th2340=th2340-360;
end
if th2340<-180
th2340=th2340+360;
end
if abs(th2341-th2340)<=abs(th2342-th2340)
th234=th2341;
else
th234=th2342;
end
m=dd5*sind(th234)-dd6*cosd(th234)*sind(theta5)+cosd(theta1)*px+sind(theta1)*py;
n=-dd6*sind(th234)*sind(theta5)-dd5*cosd(th234)+pz-dd1;
d_2=(m*m+n*n+aa2*aa2-aa3*aa3)/(2*aa2);
rz2=sqrt(m*m+n*n);
throu2=atan2d(m,n);
%反解角2
th21=atan2d(d_2,sqrt(abs(rz2*rz2-d_2*d_2)))-throu2;
th22=atan2d(d_2,-sqrt(abs(rz2*rz2-d_2*d_2)))-throu2;
%if th21 不在范围
if th21-90>180
th21=th21-360;
end
if th21-90<=-180
th21=th21+360;
end
%if th22 不在范围
if th22-90>180
th22=th22-360;
end
if th22-90<=-180
th22=th22+360;
end
%选值
if abs(th21-tem2)<=abs(th22-tem2)
theta2=th21;
else
theta2=th22;
end
%顺便求角3
th2j3=atan2d(n-aa2*sind(theta2),m-aa2*cosd(theta2));
theta3=theta2-th2j3;
%if theta3 不在范围
if theta3>180
theta3=theta3-360;
end
if theta3<=-180
theta3=theta3+360;
end
%反解角4
theta4=th234-th2j3;
%if theta4 不在范围
if theta4+90>180
theta4=theta4-360;
end
if theta4+90<=-180
theta4=theta4+360;
end

tem1=theta1;
tem2=theta2;
tem3=theta3;
tem4=theta4;
tem5=theta5;
tem6=theta6;

%打印结果
% fprintf('Here are input cart position:\n');
% PO=[px py pz ra rb rc]
% fprintf('Here are inverse joint angle:\n');
% fprintf('%f\t',theta1,theta2-90,theta3,theta4+90,theta5,theta6-90);
% fprintf('\n');

tt1=theta1;
tt2=theta2;
tt3=theta3;
tt4=theta4;
tt5=theta5;
tt6=theta6;

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

F=A01*A12*A23*A34*A45*A56;
  
fpx=F(1,4);
fpy=F(2,4);
fpz=F(3,4);
frc=atan2d(F(2,1),F(1,1));
fra=atan2d(F(1,3)*sind(frc)-F(2,3)*cosd(frc),F(2,2)*cosd(frc)-F(1,2)*sind(frc));
frb=atan2d(-F(3,1),F(1,1)*cosd(frc)+F(2,1)*sind(frc));
F(1,4)
temp=abs(fpx-px)+abs(fpy-py)+abs(fpz-pz)+abs(fra-ra)+abs(frb-rb)+abs(frc-rc);
j=j+1;
if temp<=0.00000001
    %fprintf('Correct:\n');
    %fprintf('Here are fansuan cart position:\n');
    %fprintf('%f\t',fpx,fpy,fpz,fra,frb,frc);
else
    %fprintf('Error:\n');
    j;
end
end
