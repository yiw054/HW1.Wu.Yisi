clear; clf; figure(1);

% Free [Q=Q_(dim x q)] and fixed [Q=Q_(dim x q)] node locations
Q(:,1)=[-0.5;-0.5;0];Q(:,2)=[0.5,0.5,0];Q(:,3)=[-0.5,0.5,0];Q(:,4)=[0.5,-.5,0];
Q(:,5)=[-sqrt(0.5),0,2];Q(:,6)=[sqrt(0.5),0,2];Q(:,7)=[0,sqrt(0.5),2];Q(:,8)=[0,-sqrt(0.5),2];
P=[];
[dim,q]=size(Q); p=size(P,2); n=q+p; 

% Connectivity matrix
C(  1,1)=1; C(  1,6)=-1;       % bars 
C(  2,2)=1; C(  2,5)=-1;
C(  3,3)=1; C(  3,8)=-1;
C(  4,4)=1; C(  4,7)=-1;b=4;
C(b+1,1)=1; C(b+1,4)=-1;       % strings 
C(b+2,4)=1; C(b+2,2)=-1; 
C(b+3,2)=1; C(b+3,3)=-1; 
C(b+4,3)=1; C(b+4,1)=-1;
C(b+5,5)=1; C(b+5,8)=-1;
C(b+6,8)=1; C(b+6,6)=-1;
C(b+7,6)=1; C(b+7,7)=-1;
C(b+8,7)=1; C(b+8,5)=-1;
C(b+9,8)=1; C(b+9,4)=-1;
C(b+10,3)=1; C(b+10,4)=-1;
C(b+11,5)=1; C(b+11,1)=-1;
C(b+12,1)=1; C(b+12,2)=-1;
C(b+13,7)=1; C(b+13,3)=-1;
C(b+14,3)=1; C(b+14,4)=-1;
C(b+15,6)=1; C(b+15,2)=-1;
C(b+16,2)=1; C(b+16,1)=-1;
C(b+17,5)=1; C(b+17,6)=-1;
C(b+18,8)=1; C(b+18,7)=-1;
s=18; m=b+s;


% Applied external force U=U_(dim x q)
U(1:dim,1:q)=0; 
U(:,1)=[0,0,-2];U(:,2)=[0,0,-2];U(:,3)=[0,0,-2];U(:,4)=[0,0,-2];
U(:,7)=[0,0,2];U(:,8)=[0,0,2];U(:,5)=[0,0,2];U(:,6)=[0,0,2];
%U=-U;

% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1,0.08); grid on;