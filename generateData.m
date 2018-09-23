function [ y,x ] = generateData( n )
%GENERATEDATA �������ݣ���������
%   �����Һ���sin(2*pi*x)һ�������о��Ȳ���N�����ݵ㣬����y���ϼ����׼��˹�ֲ�����������
%      yi= sin(xi)+e��
%   e����N(0,0.3^2),i<=N && i>=1, (xi, yi)��ʾ��i������,0<x<1

x = linspace(0,1,n);%����һ����0��1������������Ϊn
x = x';
y = sin(2*pi*x);%�������Ҳ��ź�
noise = normrnd(0,0.3,n,1);%����n��1�еķ���N��0,0.3^2���ֲ������������Ϊ�����ź�
y = y+noise;%��������
%��ͼ
% figure(2);
% plot(x,y,'o');
% xlabel('x');
% ylabel('y');
% title('�������n�����ݣ���������');
end

