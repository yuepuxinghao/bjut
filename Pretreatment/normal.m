function output =  normal(F)
% bw_img=imread('E:/Thesis/ViBe_Matlab/background/70.png');
% bw_img=imread('./897.png');
% figure(1),imshow(F);
img_reg = regionprops(F,  'area', 'boundingbox');  
areas = [img_reg.Area];  
rects = cat(1,  img_reg.BoundingBox);

[~, max_id] = max(areas);  
max_rect = rects(max_id, :);  
F1 = imcrop(F,max_rect);  
% show the largest connected region  
% figure(2),imshow(F1);  
%rectangle('position', max_rect, 'EdgeColor', 'r'); 
%�ߴ��һ��
[p,q] = size(F1);
if p >= 64 && q>=64
    res1 = reduce(F1,64,round(64*q/p));
    [~,n] = size(res1);
    if n <64
        n1 = fix((64 - n)/2);
        L = zeros(64,n1);
        output = [L,res1,L];
    else
        % ����������·ʱ�߶ȴ��ڿ�ȣ�����������������
        output = reduce(res1,64,64);
    end
elseif p >=64 && q<64
    sprintf('hahahaaha')
    res1 = reduce(F1,64,round(64*q/p));
    [~,n] = size(res1);
    n1 = fix((64 - n)/2);
    L = zeros(64,n1);
    output = [L,res1,L];
elseif p <64 && q<=64
    sprintf('haha')
    res1 = extend(F1,64,round(64*q/p));
    [~,n] = size(res1);
    if n <64
        n1 = fix((64 - n)/2);
        L = zeros(64,n1);
        output = [L,res1,L];
    else
        % ����������·ʱ�߶ȴ��ڿ�ȣ�����������������
        output = reduce(res1,64,64);
    end
elseif p <64 && q>64
    % ����������·ʱ�߶ȴ��ڿ�ȣ�����������������
    sprintf('haha')
    res1 = extend(F1,64,round(64*q/p));
    output = reduce(res1,64,64);
end
% figure(3),imshow(output);title('�������ͼƬ');
[m,n] = size(output);
if n == 63
    output = [output,zeros(m,1)];
end
[m,n] = size(output);
% figure(3),imshow(output);title('�������ͼƬ');
sprintf(strcat('m: ',int2str(m),'  n: ',int2str(n)))
%����Ϊ64*64

