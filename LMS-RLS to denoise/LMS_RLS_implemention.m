%% 这里写一个LMS与RLS算法自适应滤波的案例
% 可以在这里看作场景为：在一个房间内放入两个麦克风，一个放在远处采集房间噪声，一个放在说话人附近采集带噪语音
clear
close 
clc
% 读取一段语音信号
[x,fs] = audioread('speech@24kHz.wav');
% 获取信号的长度
N = length(x);
% 时间
t = (0:N-1)/fs;
%% 生成带噪信号，即在信号中加入白噪声
clean = x'; 
ref_noise = 0.1*randn(1,length(x));
mixed = clean + ref_noise;
x = mixed;
x = x(:);


%% 利用NLMS算法对带噪信号进行滤波去噪
dn = clean';   % 目标期望信号等于干净信号
dn = dn(:);
M = 16;       % 滤波器阶数
mu = 0.2;    % 步长
lambda = 0.2;


[yn,w,en] = LMS(x,dn,M,mu);

N = 1:length(x)
% 画图
subplot(4,1,1)
plot(N,x)
xlabel('iterations')
ylabel('Corrupted Speech')
axis([0 22000 -0.4 0.4]);

subplot(4,1,2)
plot(N,en,'g')
xlabel('iterations')
ylabel('Estimated Noise')
axis([0 22000 -0.4 0.4]);

subplot(4,1,3)
plot(N,yn,'r')
xlabel('iterations')
ylabel('Denoised Speech')
axis([0 22000 -0.4 0.4]);

subplot(4,1,4)
plot(N,dn)
xlabel('iterations')
ylabel('Original Speech')
axis([0 22000 -0.4 0.4]);



% 画语谱图

sspectrum(x,fs);
title('带噪信号的语谱图');

sspectrum(dn,fs);
title('纯净信号的语谱图');

sspectrum(yn,fs);
title('去噪信号的语谱图');
