clc;close all ; clear all;
%--------------------------------------------------------------------------
%��ȡͼ���ͼ����Ϣ
%--------------------------------------------------------------------------
file_jpg = ls(strcat('E:\MatlabProject\ImageProcessing','/*.jpg'));
files = cellstr(file_jpg);
fileNum =  length(files);

Ans_data=zeros(5,4,fileNum);

for n = 1 :fileNum
    [Ans_data(1,:,n),Ans_data(2,:,n),Ans_data(3,:,n),Ans_data(4,:,n),Ans_data(5,:,n)]=img_process_fuc(files{n});
end

angle = 0:45:135;
color = ['k','b','c','r','g','y'];

%--------------------------------------------------------------------------
%��ʾÿ��ͼƬ���ĸ���������õ�����
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,1);L1=plot(angle,Ans_data(1,:,n),color(n));xlabel('�Ƕ�');ylabel('����');
    set(L1,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%��ʾÿ��ͼƬ���ĸ���������õĶԱȶ�
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,2);line=plot(angle,Ans_data(2,:,n),color(n));xlabel('�Ƕ�');ylabel('�Աȶ�');
    set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%��ʾÿ��ͼƬ���ĸ���������õ���ض�
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,3);line=plot(angle,Ans_data(3,:,n),color(n));xlabel('�Ƕ�');ylabel('��ض�');
    set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%��ʾÿ��ͼƬ���ĸ���������õ���
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,4);line=plot(angle,Ans_data(4,:,n),color(n));xlabel('�Ƕ�');ylabel('��');
    set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%��ʾÿ��ͼƬ���ĸ���������õ����
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,5);line=plot(angle,Ans_data(5,:,n),color(n));xlabel('�Ƕ�');ylabel('���');
    set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%�ֱ���ʾÿ��ͼƬ���ĸ���������õ����
%--------------------------------------------------------------------------
dataName = {'����','�Աȶ�','��ض�','��','���'};
for dataNum = 1:5
    figure(dataNum+1);
    for n = 1:fileNum
        line=plot(angle,Ans_data(dataNum,:,n),color(n));xlabel('�Ƕ�');ylabel(dataName{dataNum});
        set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
        hold on;grid on
    end
end

%--------------------------------------------------------------------------
%���ֵ
%--------------------------------------------------------------------------
mean_x = Ans_data ; %��ֵ
mean_y = Ans_data ; %��ֵ
variance_x = Ans_data ; %������
variance_y = Ans_data ; %������

for dataNum = 1:5
    figure(dataNum+1);
    for n = 1:fileNum
        line=plot(angle,Ans_data(dataNum,:,n),color(n));xlabel('�Ƕ�');ylabel(dataName(dataNum));
        set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
        hold on;grid on
    end
end

% 
%     for n = 1:fileNum
%         line=plot(angle,Ans_data(dataNum,:,n),color(n));xlabel('�Ƕ�');ylabel(dataName(dataNum));
%         set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
%         hold on;grid on
%         
%     end
% E_mean = mean(energy);E_variance = sqrt(cov(energy));
% EN_mean = mean(entropy);EN_variance = sqrt(cov(entropy));
% CON_mean = mean(contrast);CON_variance = sqrt(cov(contrast));
% COR_mean =  mean(correlation) ;COR_variance = sqrt(cov(correlation));
% D_mean = mean(deficit);D_variance = sqrt(cov(deficit));


