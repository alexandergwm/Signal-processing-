%% 画语谱图
% 输入参数：
%     x     输入信号向量
%     fs    输入信号向量的采样频率
%           默认选取窗函数为hamming窗

function sspectrum(x,fs)
% 定义窗函数
w = hamming(512);
% 定义两个窗函数之间的移位
R = 58;
% 定义窗的大小
N = numel(w);
% 相邻窗之间的重合
O = N - R;
% FFT的长度
M = 512;
% 信号长度
Nx = numel(x);
% 分帧长度
L = ceil((Nx-O)/R);
% 补零
Zp = (O+L*R) - Nx;
pad = zeros(Zp,1);
% 对信号进行补零
x = [x;pad];
% 加窗画图
figure
[X,t,f] = stft_gwm(x,fs,w,R,M);
X = X(1:M/2,:);
imagesc(t,f,X);
colorbar;
set(gca,'YDir','normal');
xlabel('time/s');
title('利用长为512的hamming得到的语谱图');
ylabel('f/Hz');
