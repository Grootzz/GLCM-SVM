clc;close all ; clear all;
%--------------------------------------------------------------------------
%获取图像和图像信息
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
%显示每张图片在四个方向上求得的能量
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,1);L1=plot(angle,Ans_data(1,:,n),color(n));xlabel('角度');ylabel('能量');
    set(L1,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%显示每张图片在四个方向上求得的对比度
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,2);line=plot(angle,Ans_data(2,:,n),color(n));xlabel('角度');ylabel('对比度');
    set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%显示每张图片在四个方向上求得的相关度
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,3);line=plot(angle,Ans_data(3,:,n),color(n));xlabel('角度');ylabel('相关度');
    set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%显示每张图片在四个方向上求得的熵
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,4);line=plot(angle,Ans_data(4,:,n),color(n));xlabel('角度');ylabel('熵');
    set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%显示每张图片在四个方向上求得的逆差
%--------------------------------------------------------------------------
for n = 1:fileNum
    subplot(2,3,5);line=plot(angle,Ans_data(5,:,n),color(n));xlabel('角度');ylabel('逆差');
    set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
    hold on;grid on
end

%--------------------------------------------------------------------------
%分别显示每张图片在四个方向上求得的逆差
%--------------------------------------------------------------------------
dataName = {'能量','对比度','相关度','熵','逆差'};
for dataNum = 1:5
    figure(dataNum+1);
    for n = 1:fileNum
        line=plot(angle,Ans_data(dataNum,:,n),color(n));xlabel('角度');ylabel(dataName{dataNum});
        set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
        hold on;grid on
    end
end

%--------------------------------------------------------------------------
%求均值
%--------------------------------------------------------------------------
mean_x = Ans_data ; %均值
mean_y = Ans_data ; %均值
variance_x = Ans_data ; %均方差
variance_y = Ans_data ; %均方差

for dataNum = 1:5
    figure(dataNum+1);
    for n = 1:fileNum
        line=plot(angle,Ans_data(dataNum,:,n),color(n));xlabel('角度');ylabel(dataName(dataNum));
        set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
        hold on;grid on
    end
end

% 
%     for n = 1:fileNum
%         line=plot(angle,Ans_data(dataNum,:,n),color(n));xlabel('角度');ylabel(dataName(dataNum));
%         set(line,'color',color(n),'Linewidth',2);set(gca, 'XTick',angle); legend(files);
%         hold on;grid on
%         
%     end
% E_mean = mean(energy);E_variance = sqrt(cov(energy));
% EN_mean = mean(entropy);EN_variance = sqrt(cov(entropy));
% CON_mean = mean(contrast);CON_variance = sqrt(cov(contrast));
% COR_mean =  mean(correlation) ;COR_variance = sqrt(cov(correlation));
% D_mean = mean(deficit);D_variance = sqrt(cov(deficit));


