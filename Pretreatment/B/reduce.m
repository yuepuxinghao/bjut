function I= reduce(F,k1,k2)
% 基于局部均值的图像缩小方法
% 调用方法
% A = imread('E:/Thesis/ViBe_Matlab/background/70.png')
% B=reduce(A,0.3,0.2)
a=1/k1;
b=1/k2;
%figure(1),imshow(F);title('缩小前的图片');
[m,n]=size(F);
g=double(F);
t1=1;
for i=1:m*k1
    i1=ceil(a*i);
    t2=1;
    for j=1:n*k2
       j1=ceil(b*j);
        Y = double(g(t1:i1,t2:j1));
        I(i,j)=ceil(sum(sum(Y))/((i1-t1+1)*(j1-t2+1)));
       t2=j1+1;
    end
    t1=i1+1;
end
   I= uint8(I);
%figure(2),imshow(I);title('缩小后的图片');