clc;  
clear;  
close all;  
  
traindata = [0 1; -1 0; 2 2; 3 3; -2 -1;-4.5 -4; 2 -1; -1 -3];  
group = [1 1 -1 -1 1 1 -1 -1];  
  
testdata = [5 2;3 1;-4 -3];  
svm_struct = svmtrain(traindata,group,'Showplot',true);       % training  
Group = svmclassify(svm_struct,testdata,'Showplot',true);  
hold on;  
plot(testdata(:,1),testdata(:,2),'ro','MarkerSize',12);       % testing  
hold off

 
 