clear;
clc

M=7;

close all

kh=linspace(0.001,0.62*pi,M+1);


AA=zeros(M+1,M+1);
b=zeros(M+1,1);

% %二阶导数的系数
for ii=1:M+1 %kx=1
    AA(ii,1)=1;
    for kk=1:M
        AA(ii,kk+1)=2*cos(kk*kh(ii));
    end
    
    b(ii)=-(kh(ii))^2;
end


c=AA\b;%求系数
length(c)
digits(6)
vpa(c)'

figure;
kh=linspace((pi)/(100),(pi),100);
a=c(1);
for m=2:length(c)
    a=a+2*c(m)*cos((m-1)*kh);
end

c2=[ -2.06046, 1.03023];%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=c2(1);
for m=2:length(c2)
    b=b+2*c2(m)*cos((m-1)*kh);
end

vv=a.*b-kh.^4;
plot(vv,'k','LineWidth',2);

c2=[ -2.80906, 1.56649, -0.178303, 0.0163449];%%%%%%%%%%%%%
b=c2(1);
for m=2:length(c2)
    b=b+2*c2(m)*cos((m-1)*kh);
end

vv=a.*b-kh.^4;
hold on; plot(vv,'b','LineWidth',2);


c2=[ -3.02578, 1.75087, -0.289998, 0.0618499, -0.0109145, 0.00108555];

b=c2(1);
for m=2:length(c2)
    b=b+2*c2(m)*cos((m-1)*kh);
end

vv=a.*b-kh.^4;
hold on; plot(vv,'m','LineWidth',2);

vv=a.*a-kh.^4;
hold on; plot(vv,'r','LineWidth',2);



xlabel('percentage of kh')
ylabel('E1')
grid on
box on
legend('M1=7,M2=1','M1=7,M2=3','M1=7,M2=5','M1=7,M2=7')
axis([0 100 -0.007 0.0019])