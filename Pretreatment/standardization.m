function [iimg]= standardization(f,beta)
%����fΪ��ֵ��ͼ��beta�Ǵ�С��һ���������
bimg	= double(f);
[row,col]	= size(bimg);
[x,y]   	= meshgrid(1:col,1:row);

%----------�����󼸺ξغ���
m00	= gmoment(bimg,0,0);%������ͼ��p+q���׾غ�������m00
m10	= gmoment(bimg,1,0);%��m10
m01	= gmoment(bimg,0,1);%��m01
if  nargin==1
    inva=1;
else
    inva= 1/sqrt(beta/m00);
end
%��������
thecen1= m10/m00;
thecen2= m01/m00;
xi	= x*inva+thecen1;
yi	= y*inva+thecen2;
iimg	= interp2(x+inva*col/2+.5,y+inva*row/2+.5,bimg,xi,yi,'*linear');
wnan		= find(isnan(iimg)==1);%isnan�Ǽ��һ������ķ���ֵԪ�ء���Ӧλ�÷���ֵΪ1�����Ƿ���ֵ��λ�÷���0��%�ҵ�iimg�з���ֵ��Ԫ��λ�á�
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