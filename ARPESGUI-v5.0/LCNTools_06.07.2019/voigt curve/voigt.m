function vf= voigt(v,par0)
% vf= voigt(v,par0)
% input  --v: wavenumber
%        --par0: initial parameters. 4 by g matrix,first row is peak
%                position, second row is intensity,third row is Gaussain width, 
%                fourth row is Lorentzian width
%               
% output -- vf: voigt 


v0=par0(1,:);
s=par0(2,:);
ag=par0(3,:);
al=par0(4,:);

aD=(ones(length(v),1)*ag);

vv0=v*ones(1,length(v0))-ones(length(v),1)*v0;
x=vv0.*(sqrt(log(2)))./aD;
y=ones(length(v),1)*(al./ag)*(sqrt(log(2)));
z=x+1i*y;
w = fadf(z);       % uses The code written by Sanjar M. Abrarov and Brendan M. Quine, York
%                      % University, Canada, March 2015.
vf=real(w)*s';
end