
im=imread('安全路面.jpg','jpg');
imshow(im);
im =rgb2gray(im);
img = histeq(im);
subplot(1,2,1),imshow(im);title('均衡前')
subplot(1,2,2),imshow(img); title('均衡后');