img = imread('��ȫ·��.jpg','jpg'); %imshow(image); %��ȡͼƬ
img = rgb2gray(img);%תΪ�Ҷ�ͼ��
%img = histeq(img);%ֱ��ͼ���⻯
hist_im = imhist(img);
bar(hist_im);

