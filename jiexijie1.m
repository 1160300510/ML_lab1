clc
clear all;
%用高阶多项式函数拟合曲线
%用解析解求解两种loss的最优解（无正则项和有正则项）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%无正则项,最小二乘法
%损失（loss）函数L = (1/(2*N))*(y-Xw)'(y-Xw) = (1/(2N))*(w'X'Xw-2w'X'y+y'y)
%对w求偏导，令其为0，可得解析解为
%w = ((X'X)^-1)X'y
M = 7;%wi*x^i,i=0:M-1, the highest poly
N = 10;%number of data [xi,yi]
[y,x] = generateData(N);%生成10个随机数据
% get x in w, x is n*m
tmp=x;
clear x;
x=[];
for col = 1:M
    x = [x tmp.^(col-1)];
end
w = inv(x'*x)*x'*y;%解析解
%w = polyfit(x,y,5);%多项式函数拟合
% a = tmp';
% Y=P(6)+P(5).*a+P(4).*a.^2+P(3).*a.^3+P(2).*a.^4+P(1).*a.^5;
w = flipud(w)%将w矩阵上下翻转
%tmp is x
tmp = linspace(0,1,N);
%tmp = tmp';
Y = polyval(w,tmp);%返回n次多项式在x处的值,拟合值
%画曲线拟合图
figure(1)
title('无正则项解析解')
plot(tmp,Y);
hold on
plot(tmp,y,'o');
%无正则式loss求解L = 1/2N*(y-Xw)'(y-Xw)
L = (y-x*w)'*(y-x*w)/(2*N);
L
