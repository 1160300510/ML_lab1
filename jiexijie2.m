clc
clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��������,������С���˷�
%��ʧ��loss������L = 1/2*(y-xw)'(y-xw)+lamda/2*w'w
%w = (x'x+lamda*I)^-1 * x'y
lamda = 1e-18;
M = 7;%wi*x^i,i=0:M-1, the highest poly
N = 20;%number of data [xi,yi]
[y,x] = generateData(N);%����10���������
% get x in w, x is n*m
tmp=x;
clear x;
x=[];
for col = 1:M
    x = [x tmp.^(col-1)];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��w��loss
loss = [];
w = inv((x'*x+lamda*eye(M))) * x'* y;
%L = 1/2*(y-xw)'(y-xw)+lamda/2*w'w
L = 1/2 * (y-x*w)'*(y-x*w)+lamda/2 * (w'*w);
loss = [loss L];

% figure(1)
% plot(lamda, loss);
% xlabel('lamda');
% ylabel('loss');
% title('��ʧ����');

% [lrow,lcol] = find(loss==min(min(loss)))%�ҵ���Сloss��λ��
% lamda = lcol*1/1000
% w = inv((x'*x+lamda*eye(M))) * x'* y;
w = flipud(w);%��w�������·�ת
tmp = linspace(0,1,N);%tmp is x
figure(2)
Y = polyval(w,tmp);
title('�������������')
plot(tmp,Y);
hold on
plot(tmp,y,'o');