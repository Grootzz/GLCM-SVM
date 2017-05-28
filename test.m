angle = 0:45:135;
subplot(1,2,1),a=plot(angle);title('均衡前');
 set(a,'Linestyle','-.','color','r','Linewidth',2.5)
subplot(1,2,2),b=plot(angle,angle); title('均衡后');set(gca, 'XTick',angle);
 set(b,'Linestyle','-.','color','r','Linewidth',2.5)