img = imread('安全路面.jpg','jpg'); %imshow(image); %读取图片
img = rgb2gray(img);%转为灰度图像
%img = histeq(img);%直方图均衡化
hist_im = imhist(img);
bar(hist_im);

