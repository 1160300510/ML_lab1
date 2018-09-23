function [ y,x ] = generateData( n )
%GENERATEDATA 生成数据，加入噪声
%   在正弦函数sin(2*pi*x)一个周期中均匀产生N个数据点，并在y轴上加入标准高斯分布的噪声，即
%      yi= sin(xi)+e，
%   e服从N(0,0.3^2),i<=N && i>=1, (xi, yi)表示第i个数据,0<x<1

x = linspace(0,1,n);%产生一个从0到1的向量，长度为n
x = x';
y = sin(2*pi*x);%产生正弦波信号
noise = normrnd(0,0.3,n,1);%产生n行1列的服从N（0,0.3^2）分布的随机数，作为噪声信号
y = y+noise;%加入噪声
%画图
% figure(2);
% plot(x,y,'o');
% xlabel('x');
% ylabel('y');
% title('随机生成n个数据，加入噪声');
end

