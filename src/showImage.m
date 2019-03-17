clc;clear all;close all;

file_jpg = ls(strcat('E:\MatlabProject\Image_Processing','/*.jpg'));
files = cellstr(file_jpg);
fileNum =  length(files);


for n = 1:fileNum
    img = imread(files{n});
    subplot(2,2,n);
    imshow(img);xlabel(files{n});
end
