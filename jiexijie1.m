clc
clear all;
%�ø߽׶���ʽ�����������
%�ý������������loss�����Ž⣨����������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��������,��С���˷�
%��ʧ��loss������L = (1/(2*N))*(y-Xw)'(y-Xw) = (1/(2N))*(w'X'Xw-2w'X'y+y'y)
%��w��ƫ��������Ϊ0���ɵý�����Ϊ
%w = ((X'X)^-1)X'y
M = 7;%wi*x^i,i=0:M-1, the highest poly
N = 10;%number of data [xi,yi]
[y,x] = generateData(N);%����10���������
% get x in w, x is n*m
tmp=x;
clear x;
x=[];
for col = 1:M
    x = [x tmp.^(col-1)];
end
w = inv(x'*x)*x'*y;%������
%w = polyfit(x,y,5);%����ʽ�������
% a = tmp';
% Y=P(6)+P(5).*a+P(4).*a.^2+P(3).*a.^3+P(2).*a.^4+P(1).*a.^5;
w = flipud(w)%��w�������·�ת
%tmp is x
tmp = linspace(0,1,N);
%tmp = tmp';
Y = polyval(w,tmp);%����n�ζ���ʽ��x����ֵ,���ֵ
%���������ͼ
figure(1)
title('�������������')
plot(tmp,Y);
hold on
plot(tmp,y,'o');
%������ʽloss���L = 1/2N*(y-Xw)'(y-Xw)
L = (y-x*w)'*(y-x*w)/(2*N);
L
