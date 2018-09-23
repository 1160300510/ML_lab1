
%----------------------------------------------
clc
clear all
M = 21;%wi*x^i,i=0:M-1, the highest poly
N = 15;%number of data [xi,yi]
[y,x] = generateData(N);%����10���������
% get x in w, x is n*m
tmp=x;
clear x;
x=[];
lamda = 1e-18;
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

%-------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��w��loss
x = zeros(M,1);
w = conjgrad(Xtrain'*Xtrain+lamda.*eye(M), Xtrain'*ytrain, x);
w = flipud(w);
figure(2)
Y = polyval(w,tmp);
L = (Xvalid*w-yvalid)'*(Xvalid*w-yvalid)
title('����������ݶȷ�')
plot(tmp,Y);
hold on
plot(tmp,ytrain,'o');

%------------------------------------------
%�����ݶȷ�Ax = b,�����е�xΪ��ֵ
function [x] = conjgrad(A, b, x)
    r = b - A*x;
    p = r;
    rsold = r' * r;
    for i = 1:length(b)
        Ap = A * p;
        alpha = rsold/(p' * Ap);
        x = x + alpha*p;
        r = r - alpha*Ap;
        rsnew = r' * r;
        if sqrt(rsnew) < 1e-10
            break;
        end
        p = r + (rsnew / rsold) * p;
        rsold = rsnew;
    end
end