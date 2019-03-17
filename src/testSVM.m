 clear all ;clc;
% load fisheriris
% data = [meas(:,1),meas(:,2)];%在这里只取meas的第一列和第二列,即只选取前两个属性.
% %由于species分类中是有三个分类:setosa,versicolor,virginica,为了使问题简单,我们将其变为二分类问题:Setosa and non-Setosa
% groups  = ismember(species,'setosa');
% %随机选择训练集合测试集[有关crossvalind的使用请自己help一下]?其中cp作用是后来用来评价分类器的.
% [train, test] = crossvalind('holdOut',groups);
% cp = classperf(groups); 
% %使用svmtrain进行训练,得到训练后的结构svmStruct,在预测时使用
% svmStruct = svmtrain(data(train,:),groups(train),'showplot',true);
% %对于未知的测试集进行分类预测,
% classes=svmclassify(svmStruct,data(test,:),'showplot',true);
% classperf(cp,classes,test);

t = [1 0;5 4;2 5;7 9];
g = {'a' 'a' 'b' 'b'};
tc =[2 0;5 6;4 5;11 9]; 
cp = classperf(g);
trains = svmtrain(t,g,'Kernel_Function','rbf','showplot',true);hold on
svmclassify(trains,tc,'showplot',true);hold on

