 clear all ;clc;
% load fisheriris
% data = [meas(:,1),meas(:,2)];%������ֻȡmeas�ĵ�һ�к͵ڶ���,��ֻѡȡǰ��������.
% %����species������������������:setosa,versicolor,virginica,Ϊ��ʹ�����,���ǽ����Ϊ����������:Setosa and non-Setosa
% groups  = ismember(species,'setosa');
% %���ѡ��ѵ�����ϲ��Լ�[�й�crossvalind��ʹ�����Լ�helpһ��]?����cp�����Ǻ����������۷�������.
% [train, test] = crossvalind('holdOut',groups);
% cp = classperf(groups); 
% %ʹ��svmtrain����ѵ��,�õ�ѵ����ĽṹsvmStruct,��Ԥ��ʱʹ��
% svmStruct = svmtrain(data(train,:),groups(train),'showplot',true);
% %����δ֪�Ĳ��Լ����з���Ԥ��,
% classes=svmclassify(svmStruct,data(test,:),'showplot',true);
% classperf(cp,classes,test);

t = [1 0;5 4;2 5;7 9];
g = {'a' 'a' 'b' 'b'};
tc =[2 0;5 6;4 5;11 9]; 
cp = classperf(g);
trains = svmtrain(t,g,'Kernel_Function','rbf','showplot',true);hold on
svmclassify(trains,tc,'showplot',true);hold on

