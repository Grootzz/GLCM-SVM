clc;close all ; clear all;
%--------------------------------------------------------------------------
%��ȡͼ���ͼ����Ϣ
%--------------------------------------------------------------------------
trainFilePath = 'E:\MatlabProject\ImageProcessing\trainFile';
fileRes = ls(strcat(trainFilePath,'/*.jpg'));
files = cellstr(fileRes);
fileNum =  length(files);

data = zeros(1,fileNum);
energy_mean = data ; %���׾�
contrast_mean= data ;%�Աȶ�(���Ծ�)
correlation_mean = data ; %��ض�
entropy_mean = data ;%��
deficit_mean = data ;%������

%--------------------------------------------------------------------------
%��ȡ��������ֵ������ѵ��������
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
%��ȡ����������ֵ���÷������������
%--------------------------------------------------------------------------
classifyFilePath = 'E:\MatlabProject\ImageProcessing\classifySample';
fileRes_c = ls(strcat(classifyFilePath,'/*.jpg'));
files_c = cellstr(fileRes_c);
fileNum_c =  length(files_c);

data_c = zeros(1,fileNum_c);
energy_mean_c = data_c ; %���׾�
contrast_mean_c= data_c ;%�Աȶ�(���Ծ�)
correlation_mean_c = data_c ; %��ض�
entropy_mean_c = data_c ;%��
deficit_mean_c = data_c ;%������

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
fprintf('ʹ�������ͶԱȶ���Ϊѵ��������������������ȷ�ʣ�%f\n' ,sum(label'==sample_label)/fileNum_c);
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
