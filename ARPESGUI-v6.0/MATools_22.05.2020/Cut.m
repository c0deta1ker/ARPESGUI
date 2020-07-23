function [XCut,DCut]=Cut(ACorr,ECorr,Data,xMode,Win)
% [XCut,DCut]=Cut(ACorr,ECorr,Data,xMode,Win) calculates 1D array DCut of intensity as
% a function of 1D array XCut(raw vector of angles/momenta) for xMode='mdc', or XCut
% (column vector of energies in Energy dimension) for xMode='edc'. The input 2D array 
% Data of intensity is defined on the 1D (row) or 2D array ACorr of [warping corrected] 
% angles/momenta and the 1D (column) or 2D array ECorr of curvature corrected [aligned] 
% energies. DCut is integrated within the Win window [win1 win2] in energies (xMode='mdc') 
% or angles/momenta (xMode='edc'). XCut is calculated in the middle of Win.
% Ver. 29.12.2017

disp('- Data cut formation')

% check inputs
% - supported modes
xMode=lower(xMode);
if ~isequal(xMode,'mdc') && ~isequal(xMode,'edc')
      XCut=[]; DCut=[]; disp('Error: Only ''mdc'' and ''edc'' modes supported'); return;
end
% - integration window and its check
Win=sort(Win); 
if isequal(xMode,'mdc') Range=[max(ECorr(1,:)) min(ECorr(end,:))]; 
else Range=[max(ACorr(:,1)) min(ACorr(:,end))]; end
if Win(1)<Range(1)||Win(2)>Range(2) 
    XCut=[]; DCut=[]; disp('Error: Inconsistent integration window'); return; 
end

% remove NaNs spoiling the cumulative sum
Data(isnan(Data))=0;

% expanding ACorr and ECorr if 1D arrays
if size(ACorr,1)==1; ACorr=repmat(ACorr,size(Data,1),1); end
if size(ECorr,2)==1; ECorr=repmat(ECorr,1,size(Data,2)); end

% array permutation to reduce the 'edc' mode to 'mdc'
if isequal(xMode,'edc')
    ACorr=ACorr'; ECorr=ECorr'; Data=Data';
    T=ACorr; ACorr=ECorr; ECorr=T; clear T;
end

% parameters
de=mean(mean(diff(ECorr,1)));

% shifted energy and angle arrays
ECorr1=ECorr(1:end-1,:); ECorr2=ECorr(2:end,:);
if nargin>3; ACorr1=ACorr(1:end-1,:); end
% Data array
% cumulative array
ISum=cumsum(Data(1:end-1,:),1)-0.5*Data(1:end-1,:);
% - point 1
% - - linear index returned by find;
% - - NB: Lin1=find(ECorr1-A).*(ECorr2-A) fails if A coincides with a point on the grid
Lin1=find(ECorr1<=Win(1)&ECorr2>Win(1)); 
%if isempty(Lin1); disp('Error: Window outside the region'); return; end
% - - subscript indices of the next point in energy
[I,J]=ind2sub(size(ECorr1),Lin1); Lin2=sub2ind(size(ECorr1),I+1,J);
% - - interpolation of the linear matrices defined by linear indices
I1=ISum(Lin1)+(ISum(Lin2)-ISum(Lin1)).*(Win(1)-ECorr1(Lin1))/de; 
% - point 2
Lin1=find(ECorr1<=Win(2)&ECorr2>Win(2)); 
%if isempty(Lin1); disp('Error: Window outside the region'); return; end
[I,J]=ind2sub(size(ECorr1),Lin1); Lin2=sub2ind(size(ECorr1),I+1,J);
I2=ISum(Lin1)+(ISum(Lin2)-ISum(Lin1)).*(Win(2)-ECorr1(Lin1))/de;
% integral value
DCut=I2-I1;
% normalization
DCut=DCut*de/diff(Win);

% XCut values interpolated in the middle of Win
% - this block runs ~25% of the integration block runtime
midE=mean(Win);
Lin1=find(ECorr1<=midE&ECorr2>midE);
[I,J]=ind2sub(size(ECorr1),Lin1); Lin2=sub2ind(size(ECorr1),I+1,J);
XCut=ACorr1(Lin1)+(ACorr1(Lin2)-ACorr1(Lin1)).*(midE-ECorr1(Lin1))/de;

% transpose if the MDC mode
if isequal(xMode,'mdc'); DCut=DCut'; XCut=XCut'; end   