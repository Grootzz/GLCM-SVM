
im=imread('��ȫ·��.jpg','jpg');
imshow(im);
im =rgb2gray(im);
img = histeq(im);
subplot(1,2,1),imshow(im);title('����ǰ')
subplot(1,2,2),imshow(img); title('�����');