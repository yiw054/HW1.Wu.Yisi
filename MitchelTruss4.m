%MitchelTruss4
clear; clc;
Fi=pi/16; be=pi/6; a=sin(be)/(sin(be+Fi)); c=sin(Fi)/(sin(be+Fi));
l1=3;
% Free [Q=Q_(dim x q)] and fixed [P=P_(dim x p)] node locations
count=1;
for j=1:1:5
    for k=1:1:6-j
        if j+k==6
            P(:,j)=[real(l1*a^(j+k-1)*exp(1i*(j-k)*Fi*l1*a^(j+k-1)));imag(l1*a^(j+k-1)*exp(1i*(j-k)*Fi*l1*a^(j+k-1)))];
        else
            Q(:,count)=[real(l1*a^(j+k-1)*exp(1i*(j-k)*Fi*l1*a^(j+k-1)));imag(l1*a^(j+k-1)*exp(1i*(j-k)*Fi*l1*a^(j+k-1)))];
            count=count+1;
        end
    end
end
[dim,q]=size(Q), p=size(P,2), n=q+p; 
%% 

% Connectivity matrix
C(  1,1)=1; C(  1,5)=-1;       % bars 
C(  2,2)=1; C(  2,6)=-1;    
C(  3,3)=1; C(  3,7)=-1;                                              
C(  4,4)=1; C(  4,q+2)=-1; b=10;                                      
C(  5,5)=1; C(  5,8)=-1;       % bars 
C(  6,6)=1; C(  6,9)=-1;    
C(  7,7)=1; C(  7,q+3)=-1;                                              
C(  8,8)=1; C(  8,10)=-1;
C(9,9)=1; C(9,q+4)=-1;
C(10,10)=1;C(10,q+5)=-1;
%strings
count=1;
for j=1:1:10
    if j~=4 && j~=7 &&j~=9&&j~=10
    C(b+j,j)=1; C(b+j,j+1)=-1;
    else C(b+j,j)=1; C(b+j,q+count)=-1; count=count+1;
    end
end
s=10; m=b+s; count=1;

% Applied external force U=U_(dim x q)
%U(1:dim,1:q)=0; U(1,1)=-1;
U=randn([dim,q])/5000;

% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); grid on;