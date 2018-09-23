clc
clear all
%�ݶ��½������������������Ž�
%L = 1/2*(Xw-t)'(Xw-t)+lamda/2*w'w
%��w��ƫ��
%dw = X'(Xw-t)+lamda*w
M = 7;%wi*x^i,i=0:M-1, the highest poly
N = 15;%number of data [xi,yi]
[y,x] = generateData(N);%����10���������
% get x in w, x is n*m
tmp=x;
clear x;
x=[];
for col = 1:M
    x = [x tmp.^(col-1)];
end
%------------------cross validation(������֤����ѵ�lamda)---------------
%first, seperate data to two parts: 
%train set and validation set
Xvalid = x(2:3:14, :);  %5 validation samples
yvalid = y(2:3:14, :);
x(2:3:14, :) = [];  
y(2:3:14, :) = [];
Xtrain = x;          %10 train samples
ytrain = y;
tmp(2:3:14, :) = [];
%plot(tmp, ytrain);
%-------------------------------------------------------------
%lamda = 0;
% lamdat = [1e-18, 1e-10, 1e-5, 1e-3, 1e-2, 0.1, 1];
lamdat = 1e-18;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��w��loss
loss = [];
for lamda = lamdat
    w = gradientDescent(Xtrain,ytrain,lamda);
    w = flipud(w);%��w�������·�ת
    %������֤
    L = (Xvalid*w-yvalid)'*(Xvalid*w-yvalid)
    loss = [loss L];
end

figure(1)
plot(lamdat, loss);
xlabel('lamda');
ylabel('loss');
title('��ʧ����');

% [lrow,lcol] = find(loss==min(min(loss)))%�ҵ���Сloss��λ��
% lamda = lcol*1/1000;
% w = GradientDescentfunc(Xtrain,ytrain,0.1);
% w = flipud(w);%��w�������·�ת
figure(2)
Y = polyval(w,tmp);
L = (Xvalid*w-yvalid)'*(Xvalid*w-yvalid)
title('���������ݶ��½���')
plot(tmp,Y);
hold on
plot(tmp,ytrain,'o');

function w = gradientDescent(X, y, lamda)
% INIT = 100;
LIMIT = 0.000001;
delta = 1;
learn_rate = 0.01;
SIZE = size(X);
N = SIZE(1);
M = SIZE(2);
%��ʼw
w = zeros(M,1);
%��ʼlossֵ
loss = 1/2.*((X*w-y)'*(X*w-y)) + lamda/2.*(w'*w);
%������������
count = 0;
while delta >= LIMIT
    count = count+1;
    dw = X'*(X*w-y) + lamda.*w;
    %����w
    w = w - learn_rate * dw;
    %�µ�loss
    newloss = 1/2.*(X*w-y)'*(X*w-y) + lamda/2.*(w'*w);
    %����loss֮��Ĳ�ֵ,���㹻С��˵���ҵ���Сֵ
    delta = abs(loss - newloss)
    loss = newloss;
    %scatter(count,delta);hold on;
end
count
end
