 clc;close all;
% [heart_scale_label,heart_scale_inst] = libsvmread('heart_scale');
% model = svmtrain(heart_scale_label,heart_scale_inst);
% [predict_label,accuracy] = svmpredict(heart_scale_label,heart_scale_inst,model);

data = [176 70;180 80;161 45;163 47];

label = [1;1;-1;-1];

model = svmtrain(data,label);