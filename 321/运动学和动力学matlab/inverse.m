clear;
clc;
%variable
px=0;
py=-236.5;
pz=992.35;
ra=90;
rb=0;
rc=0;
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
tt6=th6+90;
%-------------------------
dd1=142.35;
dd2=144;
dd3=121;
dd4=113;
dd5=113;
dd6=100.5;
%-------------------------
aa2=385;
aa3=352;
%-------------------------
%transition matrix
I=[
cosd(rb)*cosd(rc)	cosd(rc)*sind(ra)*sind(rb) - cosd(ra)*sind(rc)	sind(ra)*sind(rc) + cosd(ra)*cosd(rc)*sind(rb)  px;
cosd(rb)*sind(rc)	cosd(ra)*cosd(rc) + sind(ra)*sind(rb)*sind(rc)	cosd(ra)*sind(rb)*sind(rc) - cosd(rc)*sind(ra)  py;
-sind(rb)	    	cosd(rb)*sind(ra)	                   			cosd(ra)*cosd(rb)  						  	 	pz;
0	            0	                                	  			0								   				1
]
%calculate joint angle

ay1=py-dd6*I(2,3);
ax1=dd6*I(1,3)-px;
C_1=dd3-dd2-dd4;
r_1=sqrt((ax1)*(ax1)+(ay1)*(ay1));
%%反解�?
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
%选�?
if abs(th11-tt1)<=abs(th12-tt1)
theta1=th11;
else
theta1=th12;
end

%%反解�?
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
%选�?
if abs(th51-tt5)<=abs(th52-tt5)
theta5=th51;
else
theta5=th52;
end

%%反解�?
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
%选�?
if abs(th61-tt6)<=abs(th62-tt6)
theta6=th61;
else
theta6=th62;
end
%反解�?-�?+�?
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
th2340=tt2-tt3+tt4;
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
%反解�?
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
%选�?
if abs(th21-tt2)<=abs(th22-tt2)
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
%反解�?
theta4=th234-th2j3;
%if theta4 不在范围
if theta4+90>180
theta4=theta4-360;
end
if theta4+90<=-180
theta4=theta4+360;
end
fprintf('%f\t',theta1,theta2-90,theta3,theta4+90,theta5,theta6);
fprintf('\n');
fprintf('%f\t',th1,th2,th3,th4,th5,th6);