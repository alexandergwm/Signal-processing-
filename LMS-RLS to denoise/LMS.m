%% LMS 算法
% 输入参数:
%     xn   输入的信号序列      (列向量)
%     dn   所期望的响应序列    (列向量)
%     M    滤波器的阶数        (标量)
%     mu   收敛因子(步长)      (标量)     要求大于0,小于xn的相关矩阵最大特征值的倒数    
% 输出参数:
%     W    滤波器的权值矩阵     (矩阵)
%          大小为M x itr,
%     en   误差序列(itr x 1)    (列向量)  

function [yn,w,en,noi] = LMS(xn,dn,M,mu)
% 初始化滤波器系数
N = length(xn);
w = zeros(M,1);
xin = zeros(M,1);
en = zeros(N,1);

for i = 1:N
    % 创建X(k)的输入向量
    xin = [dn(i);xin(1:end-1)];
    
    temp1 = xn(i) - w'*xin;
    en(i) = temp1;
    % 更新滤波器系数向量
    temp2 = w + 2*mu*en(i)*xin;
    w = temp2;
end

% 估计的干净语音
yn = xn - en;

% 在输出的干净语音中还存在的噪声
noi = yn - dn;
