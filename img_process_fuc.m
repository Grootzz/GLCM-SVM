function [ energy,contrast,correlation,entropy,deficit] = img_process_fuc( img_file )

img = imread(img_file,'jpg'); %imshow(image); %读取图片
img = rgb2gray(img);%转为灰度图像
img = histeq(img);%直方图均衡化

gray_leave = 256 ;%灰度级数
gray_leave_com = 32 ;%压缩后灰度级数
dx = 1 ; dy = 1 ;%搜寻灰度步进长度
[L,W] = size(img);%图片的尺寸，L长 ，W宽

%--------------------------------------------------------------------------
%2.为了减少计算量，对原始图像灰度级压缩，将img量化成16级
%--------------------------------------------------------------------------
for i = 1 : L
    for j = 1 : W
        for n = 1 : gray_leave_com
            if (n-1)*(gray_leave/gray_leave_com) <= img(i ,j)  && ...
                    img(i ,j)<= (n-1)*(gray_leave/gray_leave_com )+(gray_leave/gray_leave_com )-1
                img(i ,j) = n-1;
            end
        end
    end
end

%--------------------------------------------------------------------------
%3.计算四个共生矩阵P,取距离为1，角度分别为0,45,90,135
%--------------------------------------------------------------------------
P = zeros(gray_leave_com,gray_leave_com,4);

for m = 1 : gray_leave_com
    for n  = 1 : gray_leave_com
        for i = 1 : L
            for j = 1 : W
                if (j<=W-dy && img(i , j) == m-1 && img(i ,j+dy) ==n-1) %角度为0
                    P(m , n , 1) = P(m, n ,1) + 1 ;
                end
                if (i<=L-dx && j<=W-dy && img(i , j) == m-1 && img(i +dx ,j+dy) ==n-1) %角度为45
                    P(m , n , 2) = P(m, n ,2) + 1;
                end
                if (i<=L-dx && img(i , j) == m-1 && img(i +dx ,j) ==n-1) %角度为90
                    P(m , n , 3) = P(m, n ,3) + 1;
                end
                if ( j>dy && i<=L-dx && img(i , j) == m-1 && img(i +dx ,j - dy ) ==n-1) %角度为135
                    P(m , n , 4) = P(m, n ,4) + 1;
                end
            end
        end
    end
end

%%---------------------------------------------------------
% 对共生矩阵归一化
%%---------------------------------------------------------
for n=1:4
    P(:,:,n)=P(:,:,n)/sum(sum(P(:,:,n)));
end

%--------------------------------------------------------------------------
%4.求共生矩阵计算(二阶矩)能量、熵、惯性矩、相关、逆差分阵5个纹理参数
%--------------------------------------------------------------------------
Ans_data = zeros(1,4);
energy = Ans_data ; %二阶矩
contrast= Ans_data ;%对比度(惯性矩)
correlation = Ans_data ; %相关度
entropy = Ans_data ;%熵
deficit = Ans_data ;%逆差分阵
mean_x = Ans_data ; %均值
mean_y = Ans_data ; %均值
variance_x = Ans_data ; %均方差
variance_y = Ans_data ; %均方差
Exy = Ans_data;

for n = 1:4
    energy(n) = sum(sum(P(:,:,n).^2));%二阶矩
    for i = 1:gray_leave_com
        for j = 1:gray_leave_com
            if P(i, j ,n)~=0
                entropy(n) = -P(i, j ,n)*log(P(i, j ,n)) + entropy(n) ;%熵
            end
            contrast(n) = ((i - j)^2)*P(i, j ,n) + contrast(n) ;%对比度
            mean_x(n) = i*P(i, j ,n) + mean_x(n);
            mean_y(n) = j*P(i, j ,n) + mean_y(n);
        end
    end
end
for n = 1:4
    for i = 1:gray_leave_com
        for j = 1:gray_leave_com
            variance_x(n) = (i - mean_x(n))^2 * P(i, j ,n) + variance_x(n);
            variance_y(n) = (j - mean_y(n))^2 * P(i, j ,n) + variance_y(n);
            Exy(n) = i*j*P(i, j ,n) +  Exy(n) ;
            deficit(n) = P(i, j ,n)/(1+(i-j)^2) + deficit(n) ;
        end
    end
    correlation(n) = (Exy(n) - mean_x(n)*mean_y(n))/(variance_x(n)*variance_y(n));
end
end

