
clear;
clc
close all;

load('figure4a.mat')
seis_recordaa=seis_record;
plotimage(p1(51:end,50:end-50))
xlabel('x/dx')
ylabel('z/dz')
title('')

load('figure4b.mat')
seis_recordbb=seis_record;
plotimage(p1(51:end,50:end-50))
xlabel('x/dx')
ylabel('z/dz')
title('')



load('figure4c.mat')
seis_recordcc=seis_record;
plotimage(p1(51:end,50:end-50))
xlabel('x/dx')
ylabel('z/dz')
title('')


load('figure4d.mat')
seis_recorddd=seis_record;



load('figure4f.mat')
seis_recordff=seis_record;



load('figure4h.mat')
seis_recordhh=seis_record;



% % % 
plotimage((1:1000)*2,seis_recordaa(:,50:end-50))
xlabel('x/dx')
ylabel('Time(ms)')
title('')

plotimage((1:1000)*2,seis_recordbb(:,50:end-50))
xlabel('x/dx')
ylabel('Time(ms)')
title('')

plotimage((1:1000)*2,seis_recordcc(:,50:end-50))
xlabel('x/dx')
ylabel('Time(ms)')
title('')


figure;
plot((1:1000)*2,seis_recordaa(:,300+50),'b')
hold on;plot((1:1000)*2,seis_recordbb(:,300+50),'k')
hold on;plot((1:1000)*2,seis_recordcc(:,300+50),'r')
hold on;plot((1:1000)*2,seis_recorddd(:,300+50),'m-.')
% hold on;plot((1:1000)*2,seis_recordee(:,300+50),'b')
hold on;plot((1:1000)*2,seis_recordff(:,300+50),'c-.')
% hold on;plot((1:1000)*2,seis_recordgg(:,300+50),'k-.')
hold on;plot((1:1000)*2,seis_recordhh(:,300+50),'g-.')

% % 
legend('Tra','Lax-Tra(M1=M2=7)','Lax-New','Lax-Tra M2=1','Lax-Tra M2=3','Lax-Tra M2=5')
% % % axis([1 590 -8*10^-5 10*10^-5])
grid on
xlabel('Time(ms)')
ylabel('Amp')

figure;
% plot(seis_recordaa(:,300+50),'b')



hold on;plot((1:1000)*2,seis_recordff(:,300+50)-seis_recordbb(:,300+50),'b')

hold on;plot((1:1000)*2,seis_recordhh(:,300+50)-seis_recordbb(:,300+50),'r')

hold on;plot((1:1000)*2,seis_recordcc(:,300+50)-seis_recordbb(:,300+50),'k')

% % 
% legend('Lax-New','Lax-Tra M2=1','Lax-Tra M2=3','Lax-Tra M2=5')
legend('The difference between the Lax-Tra(M1=7,M2=3) and the Lax-Tra(M1=M2=7)',...
    'The difference between the Lax-Tra(M1=7,M2=5) and the Lax-Tra(M1=M2=7)','The difference between the Lax-New and the Lax-Tra(M1=M2=7)')
% % % axis([1 590 -8*10^-5 10*10^-5])
grid on
xlabel('Time(ms)')
ylabel('Amp difference')
box on
