function [iimg]= standardization(f,beta)
%输入f为二值化图像，beta是大小归一化的面积。
bimg	= double(f);
[row,col]	= size(bimg);
[x,y]   	= meshgrid(1:col,1:row);

%----------调用求几何矩函数
m00	= gmoment(bimg,0,0);%调用求图像（p+q）阶矩函数。求m00
m10	= gmoment(bimg,1,0);%求m10
m01	= gmoment(bimg,0,1);%求m01
if  nargin==1
    inva=1;
else
    inva= 1/sqrt(beta/m00);
end
%计算重心
thecen1= m10/m00;
thecen2= m01/m00;
xi	= x*inva+thecen1;
yi	= y*inva+thecen2;
iimg	= interp2(x+inva*col/2+.5,y+inva*row/2+.5,bimg,xi,yi,'*linear');
wnan		= find(isnan(iimg)==1);%isnan是检测一个数组的非数值元素。相应位置返回值为1，不是非数值的位置返回0。%找到iimg中非数值的元素位置。
iimg(wnan)	= zeros(size(wnan));

function	[m_pq]=gmoment(img,p,q)
if nargin~=3
	p=0;q=0;
end
[row,col]	= size(img);
[x,y]   	= meshgrid(1:col,1:row);
x		= x.^p;
y		= y.^q;

gmom		= x.*y.*double(img);
m_pq		= sum(sum(gmom));