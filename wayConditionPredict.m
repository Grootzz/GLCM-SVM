clc;close all ; clear all;
%--------------------------------------------------------------------------
%获取图像和图像信息
%--------------------------------------------------------------------------
trainFilePath = 'E:\MatlabProject\ImageProcessing\trainFile';
fileRes = ls(strcat(trainFilePath,'/*.jpg'));
files = cellstr(fileRes);
fileNum =  length(files);

data = zeros(1,fileNum);
energy_mean = data ; %二阶矩
contrast_mean= data ;%对比度(惯性矩)
correlation_mean = data ; %相关度
entropy_mean = data ;%熵
deficit_mean = data ;%逆差分阵

%--------------------------------------------------------------------------
%获取样本特征值，用于训练分类器
%--------------------------------------------------------------------------
ans_data=zeros(5,4,fileNum);
for n = 1 :fileNum
    [ans_data(1,:,n),ans_data(2,:,n),ans_data(3,:,n),ans_data(4,:,n),ans_data(5,:,n)]=img_process_fuc(files{n});
    energy_mean(n)=mean(ans_data(1,:,n));
    contrast_mean(n)=mean(ans_data(2,:,n));
    correlation_mean(n)=mean(ans_data(3,:,n));
    entropy_mean(n)=mean(ans_data(4,:,n));
    deficit_mean(n)=mean(ans_data(5,:,n));
end
figure(1);
train  = [energy_mean;contrast_mean];
label = [ones(1,21),ones(1,21)*(-1)];
classifer = svmtrain(train',label','Kernel_Function','polynomial' ,'showplot',true);hold on;

%--------------------------------------------------------------------------
%获取待分类特征值，用分类器对其分类
%--------------------------------------------------------------------------
classifyFilePath = 'E:\MatlabProject\ImageProcessing\classifySample';
fileRes_c = ls(strcat(classifyFilePath,'/*.jpg'));
files_c = cellstr(fileRes_c);
fileNum_c =  length(files_c);

data_c = zeros(1,fileNum_c);
energy_mean_c = data_c ; %二阶矩
contrast_mean_c= data_c ;%对比度(惯性矩)
correlation_mean_c = data_c ; %相关度
entropy_mean_c = data_c ;%熵
deficit_mean_c = data_c ;%逆差分阵

ans_data_c=zeros(5,4,fileNum_c);

for n = 1 :fileNum_c
    [ans_data_c(1,:,n),ans_data_c(2,:,n),ans_data_c(3,:,n),ans_data_c(4,:,n),ans_data_c(5,:,n)]=img_process_fuc(files_c{n});
    energy_mean_c(n)=mean(ans_data_c(1,:,n));
    contrast_mean_c(n)=mean(ans_data_c(2,:,n));
    correlation_mean_c(n)=mean(ans_data_c(3,:,n));
    entropy_mean_c(n)=mean(ans_data_c(4,:,n));
    deficit_mean_c(n)=mean(ans_data_c(5,:,n));
end

sample_data  = [energy_mean_c;contrast_mean_c];
label = [ones(1,4),ones(1,4)*(-1)];
sample_label=svmclassify(classifer,sample_data','showplot',true);hold on;
fprintf('使用能量和对比度作为训练分类器的样本，其正确率：%f\n' ,sum(label'==sample_label)/fileNum_c);
% figure(2);
% train  = [energy_mean;correlation_mean];
% label = [ones(1,21),ones(1,21)*(-1)];
% svmtrain(train',label','Kernel_Function','polynomial','showplot',true);
% 
% figure(3);
% train  = [energy_mean;entropy_mean];
% label = [ones(1,21),ones(1,21)*(-1)];
% svmtrain(train',label','Kernel_Function','polynomial','showplot',true);
% 
% figure(4);
% train  = [energy_mean;deficit_mean];
% label = [ones(1,21),ones(1,21)*(-1)];
% svmtrain(train',label','Kernel_Function','polynomial','showplot',true);
% 
% figure(6);
% train  = [contrast_mean;entropy_mean];
% label = [ones(1,21),ones(1,21)*(-1)];
% svmtrain(train',label','Kernel_Function','polynomial','showplot',true);
% 
% figure(7);
% train  = [contrast_mean;deficit_mean];
% label = [ones(1,21),ones(1,21)*(-1)];
% svmtrain(train',label','Kernel_Function','polynomial','showplot',true);
% 
% figure(8);
% train  = [correlation_mean;entropy_mean];
% label = [ones(1,21),ones(1,21)*(-1)];
% svmtrain(train',label','Kernel_Function','polynomial','showplot',true);
% 
% figure(9);
% train  = [correlation_mean;deficit_mean];
% label = [ones(1,21),ones(1,21)*(-1)];
% svmtrain(train',label','Kernel_Function','polynomial','showplot',true);
% 
% figure(10);
% train  = [entropy_mean;deficit_mean];
% label = [ones(1,21),ones(1,21)*(-1)];
% svmtrain(train',label','Kernel_Function','polynomial','showplot',true);
