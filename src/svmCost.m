function [cost grad] = svmCost(w, X, y, lambda)  
% cost = HingeLoss^2 + lambda*||w||^2  
% 1 2 3 4 5 step  
yp = X*w;  
idx = find(yp.*y<1);  
err = yp(idx)-y(idx);  
cost = err'*err + lambda*w'*w;  
grad = 2*X(idx,:)'*err + 2*lambda*w;  
end  