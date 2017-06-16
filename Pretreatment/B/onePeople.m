clear
bw_img=imread('E:/Thesis/ViBe_Matlab/background/70.png');
% bw_img=imread('./897.png');
img_reg = regionprops(bw_img,  'area', 'boundingbox');  
areas = [img_reg.Area];  
rects = cat(1,  img_reg.BoundingBox);

[~, max_id] = max(areas);  
max_rect = rects(max_id, :);  
B1 = imcrop(bw_img,max_rect);  
% show the largest connected region  
figure(2),imshow(B1);  
%rectangle('position', max_rect, 'EdgeColor', 'r'); 
%尺寸归一化
[p,q] = size(B1);
%缩放为64*64

