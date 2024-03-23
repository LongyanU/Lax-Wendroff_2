%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%            High-order time discretizations in seismic modeling
%%%%%%%%%                作者：梁文全  Lax-Wendroff methods   %%%%%%%%%%%%%%%%%
% 时间已过 32.458271 秒。
clear
clc %%%%%%%
close all
nt=1000;    % number of time steps
eps=.6;     % stability
isnap=30;    % snapshot sampling


% 
nz=500;
nx=500;
v=4000*ones(nz,nx);

for ii=1:100
    for jj=1:nx
        v(ii,jj)=2800;
    end
end

for ii=100:150
    for jj=1:nx
        v(ii,jj)=3200;
    end
end
p=zeros([nz nx]); pboundarynew=p;pdan=p;
dx=20;  %calculate space increment
h=dx;
x=(0:(nx-1))*dx;
z=(0:(nz-1))*dx;  % initialize space coordinates
dt=0.002; % calculate time step from stability criterion
tau=dt;
% r2=v.*v.*dt*dt/dx/dx;
v2=v.*v;

f0=70;
t=(1:nt)*dt;
t0=4/f0;                       % initialize time axis
src=10^6*exp(-f0^2*(t-t0).*(t-t0));              % source time function
src=-diff(diff(src))/dx^2;				% time derivative to obtain gaussian


seis_record=zeros(nt,nx);
p=zeros([nz nx]); pnew=p; pold=p;
d2px=p;
d2pz=p;

% Source location
% zs=nz/2;
% xs=nx/2;

zs=51;
xs=nx/2;




p=zeros([nz nx]); 
coeff1= [ 1.83806, -0.355029, 0.100949, -0.0291963, 0.00730575, -0.00135064, 0.000135486];
temp1= -3.12175;

tic
for it=1:nt-2,
    
    p(zs,xs)= p(zs,xs)+src(it)*dt^2;
    d2px11=(circshift(p,[0 -1])+circshift(p,[0 1]));
    d2px12=(circshift(p,[0 -2])+circshift(p,[0 2]));
    d2px13=(circshift(p,[0 -3])+circshift(p,[0 3]));
    d2px14=(circshift(p,[0 -4])+circshift(p,[0 4]));
    d2px15=(circshift(p,[0 -5])+circshift(p,[0 5]));
    d2px16=(circshift(p,[0 -6])+circshift(p,[0 6]));
    d2px17=(circshift(p,[0 -7])+circshift(p,[0 7]));
    
    d2pz11=(circshift(p,[-1 0])+circshift(p,[1 0]));
    d2pz12=(circshift(p,[-2 0])+circshift(p,[2 0]));
    d2pz13=(circshift(p,[-3 0])+circshift(p,[3 0]));
    d2pz14=(circshift(p,[-4 0])+circshift(p,[4 0]));
    d2pz15=(circshift(p,[-5 0])+circshift(p,[5 0]));
    d2pz16=(circshift(p,[-6 0])+circshift(p,[6 0]));
    d2pz17=(circshift(p,[-7 0])+circshift(p,[7 0]));
    
        d2px=coeff1(1)*d2px11+coeff1(2)*d2px12+coeff1(3)*d2px13+coeff1(4)*d2px14+coeff1(5)*d2px15+coeff1(6)*d2px16...
        +coeff1(7)*d2px17;
    d2pz=coeff1(1)*d2pz11+coeff1(2)*d2pz12+coeff1(3)*d2pz13+coeff1(4)*d2pz14+coeff1(5)*d2pz15+coeff1(6)*d2pz16...
        +coeff1(7)*d2pz17;
    

    
    d2pxz=v2.*(d2px+d2pz+2*temp1*p)/h^2;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    pnew=2*p-pold+dt^2*(d2pxz);
    pold=p;
    p=pnew;
    
    
    
 [pold,p]=spongeABC(pold,p,nx,nz,50,50,0.007);
    seis_record(it,:)=p(zs,:);

      if it==600
        p1=p;
      end
    
    if it==800
        p2=p;
    end
     if it==460
        p3=p;
      end
    
    if rem(it,isnap)== 0,
        imagesc(x,z,p), axis equal
        colormap gray
        xlabel('x'),ylabel('z')
        title(sprintf(' Time step: %i - Max ampl: %g ',it,max(max(p))))
        drawnow
    end
    
    
    
end
toc
save('figure4a.mat')
