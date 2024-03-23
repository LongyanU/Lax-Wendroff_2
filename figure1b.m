clear;
clc

M=7;

close all

kh=linspace(0.001,0.62*pi,M+1);


AA=zeros(M+1,M+1);
b=zeros(M+1,1);

for ii=1:M+1 %kx=1
    AA(ii,1)=( 2*cos(kh(ii))-2);
    for kk=1:M
        AA(ii,kk+1)=2*cos(kk*kh(ii))*( 2*cos(kh(ii))-2);
    end
    
    b(ii)=(kh(ii))^4;
end


c=AA\b;%��ϵ��
length(c)
digits(6)
vpa(c)'
% c=[ -4.8481, 3.17198, -0.983605, 0.303994, -0.0846446, 0.0191256, -0.00304942, 0.000254116];

kh=linspace((pi)/(100),(pi),100);


a=c(1)*( 2*cos(kh)-2);

for m=2:length(c)
    a=a+2*c(m)*cos((m-1)*kh).*( 2*cos(kh)-2);
end

vv=a-kh.^4;
figure;
plot(vv,'k','LineWidth',2);



grid on
% 
axis([0 100 -0.007 0.0019])
legend('M1=7,M2=1')
xlabel('percentage of kh')
ylabel('E1')
box on
