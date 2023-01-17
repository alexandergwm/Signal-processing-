%% RLS 算法
% 输入参数:
%     xn   输入的信号序列      (列向量)
%     dn   所期望的响应序列    (列向量)
%     M    滤波器的阶数        (标量)
%     lambda  权重
% 输出参数:
%     W    滤波器的权值矩阵     (矩阵)
%          大小为M x itr,
%     en   误差序列(itr x 1)    (列向量)  
%     y    输出系数

function [yn,w,en] = RLS(xn,dn,M,lambda)
% 获取参考信号的长度
N = length(dn);
% 初始维纳解中R^-1的值
I = eye(M);
a = 0.01;
p = a * I;

% 初始化滤波器系数
w1 = zeros(M,1);
yn = zeros(N,1);
en = zeros(N,1);
xx = zeros(M,1);

for i = 1:N
    % 创建X(k)的输入向量
    xx = [xn(i);xx(1:M-1)];
    k = (p * xx) ./ (lambda + xx' * p *xx);
    yn(i) = xx'*w1;
    en(i) = dn(i) - yn(i);
    w1 = w1 + k * en(i);
    p = (p - k * xx' *p)./lambda;
    w(:,i) = w1;
end
end