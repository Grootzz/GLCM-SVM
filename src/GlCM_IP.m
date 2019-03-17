clc;clear all;close all;
img = imread('��Ţ·��.jpg','jpg'); %imshow(image); %��ȡͼƬ
img = rgb2gray(img);
img = histeq(img);imshow(img);
gray_leave = 256 ;%�Ҷȼ���
gray_leave_com = 16 ;%ѹ����Ҷȼ���
dx = 1 ; dy = 1 ;%��Ѱ�ҶȲ�������
[L,W] = size(img);%ͼƬ�ĳߴ磬L�� ��W��
%--------------------------------------------------------------------------
%2.Ϊ�˼��ټ���������ԭʼͼ��Ҷȼ�ѹ������img������16��
%--------------------------------------------------------------------------

for i = 1 : L
    for j = 1 : W
        for n = 1 : gray_leave_com
            if (n-1)*(gray_leave/gray_leave_com) <= img(i ,j)  &&  img(i ,j)<= (n-1)*(gray_leave/gray_leave_com )+(gray_leave/gray_leave_com )-1
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
                if (j<W && img(i , j) == m-1 && img(i ,j+dy) ==n-1) %�Ƕ�Ϊ0
                    P(m , n , 1) = P(m, n ,1) + 1 ;
                end
                if (i<L && j<W && img(i , j) == m-1 && img(i +dx ,j+dy) ==n-1) %�Ƕ�Ϊ45
                P(m , n , 2) = P(m, n ,2) + 1;
                end
                if (i<L && img(i , j) == m-1 && img(i +dx ,j) ==n-1) %�Ƕ�Ϊ90
                P(m , n , 3) = P(m, n ,3) + 1;
                end
                if ( j>1 && i<L && img(i , j) == m-1 && img(i +dx ,j - dy ) ==n-1) %�Ƕ�Ϊ135
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
%4.�Թ����������(���׾�)�������ء����Ծء���ء�������5���������
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
            contrast(n) = (i - j)^2*P(i, j ,n) + contrast(n) ;
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
sprintf('0,45,90,135�����ϵ���������Ϊ�� %f, %f, %f, %f' , energy(1),energy(2),energy(3),energy(4))
sprintf('0,45,90,135�����ϵ�������Ϊ�� %f, %f, %f, %f' , entropy(1),entropy(2),entropy(3),entropy(4))
sprintf('0,45,90,135�����ϵĶԱȶȣ����Ծأ�����Ϊ�� %f, %f, %f, %f' , contrast(1),contrast(2),contrast(3),contrast(4))
sprintf('0,45,90,135�����ϵ���ض�����Ϊ�� %f, %f, %f, %f' , correlation(1),correlation(2),correlation(3),correlation(4))
sprintf('0,45,90,135�����ϵ���������Ϊ�� %f, %f, %f, %f' , deficit(1),deficit(2),deficit(3),deficit(4))

subplot(3,2,1);plot(energy,'r');xlabel('�Ƕ�');ylabel('����');grid on
subplot(3,2,2);plot(entropy);xlabel('�Ƕ�');ylabel('��');grid on
subplot(3,2,3);plot(contrast);xlabel('�Ƕ�');ylabel('�Աȶ�');grid on
subplot(3,2,4);plot(correlation);xlabel('�Ƕ�');ylabel('��ض�');grid on
subplot(3,2,5);plot(deficit);xlabel('�Ƕ�');ylabel('���');grid on
%--------------------------------------------------------------------------
%5.�Թ�����������������ء����Ծء���ء�������5����������ľ�ֵ�ͷ���
%--------------------------------------------------------------------------
E_mean = mean(energy);E_variance = sqrt(cov(energy));
EN_mean = mean(entropy);EN_variance = sqrt(cov(entropy));
CON_mean = mean(contrast);CON_variance = sqrt(cov(contrast));
COR_mean =  mean(correlation) ;COR_variance = sqrt(cov(correlation));
D_mean = mean(deficit);D_variance = sqrt(cov(deficit));

sprintf('�����ľ�ֵ�ͱ�׼��ֱ�Ϊ�� %f,%f',E_mean,E_variance)
sprintf('�صľ�ֵ�ͱ�׼��ֱ�Ϊ�� %f,%f',EN_mean,EN_variance)
sprintf('���Ծصľ�ֵ�ͱ�׼��ֱ�Ϊ�� %f,%f',CON_mean,CON_variance)
sprintf('����Եľ�ֵ�ͱ�׼��ֱ�Ϊ�� %f,%f',COR_mean,COR_variance)
sprintf('����ľ�ֵ�ͱ�׼��ֱ�Ϊ�� %f,%f',D_mean,D_variance)
