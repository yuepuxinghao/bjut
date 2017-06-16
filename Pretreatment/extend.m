function Output = extend(A,le,wi)

%双线性插值法放大2倍 
% A = imread('E:/Thesis/ViBe_Matlab/background/70.png')
% extend(A,2,2);
[m,n] = size(A);      %读取A的行和列 
A = [A;zeros(1,n)];   %在A的最后一行加入两行0
A = [A zeros(m+1,1)]; %在A的最后一列加入两列0
% figure(1),imshow(A);title('放大前的图片');
%这样A就变成(m+1)x(n+1)的矩阵，这是为了解决索引A矩阵时的边界溢出问题

ini_u = (m-1)/(le-1); %步长比，如果把原来的一步A(1,1)到A(2,1)看做1，那么计算放大后的
ini_v = (n-1)/(wi-1); %图像B(2,1)相当于计算A(1+ini_u,1)，即每步加ini_u
         

Output = zeros(le,wi);            %初始化输出矩阵
for j = 1:wi;                      %左边两个语句的功能是：z_u,z_v向左取整，u,v取小数，原理如下
    z_v = floor((j-1)*ini_v+1);     %比如A为3x3的矩阵，要放大为Output是4x4大小,即放大了4/3倍， 
      v = (j-1)*ini_v+1 - z_v;      %新的一步的距离相当于原来的(3-1)/(4-1)=0.66667
    for i = 1:le;                  %Output(1,1) = A(1,1)       %(1-1)*0.66667+1=1
        z_u = floor((i-1)*ini_u+1); %Output(1,2) = A(1,1.66667) %(2-1)*0.66667+1=1.66667
          u = (i-1)*ini_u+1 - z_u;  %Output(1,3) = A(1,2.33334) %(3-1)*0.66667+1=2.33334
                                    %Output(1,4) = A(1,3.00001) %(4-1)*0.66667+1=3.00001
%===================下面是双线性插值的代码实现================================   
        Output(i,j) = (1 - u)*(1 - v)*A(z_u,     z_v    ) + ...
                      (1 - u)* v     *A(z_u,     z_v + 1) + ...
                       u     *(1 - v)*A(z_u + 1, z_v    ) + ...
                       u     * v     *A(z_u + 1, z_v + 1);
    end
end
% figure(2),imshow(Output);title('放大后的图片');