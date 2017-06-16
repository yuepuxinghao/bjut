
 for i=49:106
      A=imread(['E:/bjut/ViBe_Matlab/background/',num2str(i,'%03d'),'.png']);
      A1 = normal(A);
      imwrite(A1,['E:/bjut/Pretreatment/goal/',num2str(i),'.png'])
      figure(1),imshow(A1);title('预处理后的图片');
 end