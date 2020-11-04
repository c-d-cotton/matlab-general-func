function [xif,Pf,xic,Pc]=kalman(y,F,H,Q,S,R)
% Model:
% xt = F xtm1 + S vt
% yt = H' xt + wt
% vt \sim N(0, Q)
% wt \sim N(0, R)






if isempty(R)
	R=0;
end

sizeF=size(F);
nostates=sizeF(1);
T=length(y);

% xif=rep(NA,T) #xi(t,t-1)
xif=repmat(NaN,nostates,T+1);
Pf=repmat(NaN,nostates,nostates,T+1);

%initial values of xi and P
xif(:,1)=repmat(0,nostates,1);
Pf(:,:,1)=reshape(inv(eye(nostates^2)-kron(F,F))*reshape(S*Q*S',nostates^2,1),nostates,nostates);
    
xic=repmat(NaN,nostates,T);
Pc=repmat(NaN,nostates,nostates,T);

for t=1:T
    xic(:,t)=xif(:,t)+Pf(:,:,t)*H*inv(H'*Pf(:,:,t)*H+R)*(y(t)-H'*xif(:,t));
    Pc(:,:,t)=Pf(:,:,t)-Pf(:,:,t)*H*inv(H'*Pf(:,:,t)*H+R)*H'*Pf(:,:,t);
    xif(:,t+1)=F*xic(:,t);
    Pf(:,:,t+1)=F*Pc(:,:,t)*F'+S*Q*S';
end
