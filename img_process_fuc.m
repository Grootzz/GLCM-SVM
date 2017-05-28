function [ energy,contrast,correlation,entropy,deficit] = img_process_fuc( img_file )

img = imread(img_file,'jpg'); %imshow(image); %��ȡͼƬ
img = rgb2gray(img);%תΪ�Ҷ�ͼ��
img = histeq(img);%ֱ��ͼ���⻯

gray_leave = 256 ;%�Ҷȼ���
gray_leave_com = 32 ;%ѹ����Ҷȼ���
dx = 1 ; dy = 1 ;%��Ѱ�ҶȲ�������
[L,W] = size(img);%ͼƬ�ĳߴ磬L�� ��W��

%--------------------------------------------------------------------------
%2.Ϊ�˼��ټ���������ԭʼͼ��Ҷȼ�ѹ������img������16��
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
%3.�����ĸ���������P,ȡ����Ϊ1���Ƕȷֱ�Ϊ0,45,90,135
%--------------------------------------------------------------------------
P = zeros(gray_leave_com,gray_leave_com,4);

for m = 1 : gray_leave_com
    for n  = 1 : gray_leave_com
        for i = 1 : L
            for j = 1 : W
                if (j<=W-dy && img(i , j) == m-1 && img(i ,j+dy) ==n-1) %�Ƕ�Ϊ0
                    P(m , n , 1) = P(m, n ,1) + 1 ;
                end
                if (i<=L-dx && j<=W-dy && img(i , j) == m-1 && img(i +dx ,j+dy) ==n-1) %�Ƕ�Ϊ45
                    P(m , n , 2) = P(m, n ,2) + 1;
                end
                if (i<=L-dx && img(i , j) == m-1 && img(i +dx ,j) ==n-1) %�Ƕ�Ϊ90
                    P(m , n , 3) = P(m, n ,3) + 1;
                end
                if ( j>dy && i<=L-dx && img(i , j) == m-1 && img(i +dx ,j - dy ) ==n-1) %�Ƕ�Ϊ135
                    P(m , n , 4) = P(m, n ,4) + 1;
                end
            end
        end
    end
end

%%---------------------------------------------------------
% �Թ��������һ��
%%---------------------------------------------------------
for n=1:4
    P(:,:,n)=P(:,:,n)/sum(sum(P(:,:,n)));
end

%--------------------------------------------------------------------------
%4.�����������(���׾�)�������ء����Ծء���ء�������5���������
%--------------------------------------------------------------------------
Ans_data = zeros(1,4);
energy = Ans_data ; %���׾�
contrast= Ans_data ;%�Աȶ�(���Ծ�)
correlation = Ans_data ; %��ض�
entropy = Ans_data ;%��
deficit = Ans_data ;%������
mean_x = Ans_data ; %��ֵ
mean_y = Ans_data ; %��ֵ
variance_x = Ans_data ; %������
variance_y = Ans_data ; %������
Exy = Ans_data;

for n = 1:4
    energy(n) = sum(sum(P(:,:,n).^2));%���׾�
    for i = 1:gray_leave_com
        for j = 1:gray_leave_com
            if P(i, j ,n)~=0
                entropy(n) = -P(i, j ,n)*log(P(i, j ,n)) + entropy(n) ;%��
            end
            contrast(n) = ((i - j)^2)*P(i, j ,n) + contrast(n) ;%�Աȶ�
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

