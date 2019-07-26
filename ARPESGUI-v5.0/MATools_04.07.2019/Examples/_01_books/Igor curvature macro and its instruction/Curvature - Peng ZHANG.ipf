#pragma rtGlobals=1		// Use modern global access method.

//////  Since Curvature Panel of IOP doesn't initialize in the right way  //////////
function ini_pan()

	string currfolder = getdatafolder(1)
	SetVariable setvar_EDCT value=$currfolder+"T_EDCT"
	SetVariable setvar_EDCW value=$currfolder+"T_EDCW"
	SetVariable setvar_EDCF value=T_EDCF
	SetVariable setvar_MDCT value=T_MDCT
	SetVariable setvar_MDCW value=T_MDCW
	SetVariable setvar_MDCF value=T_MDCF
	SetVariable setvar_twoDW value=T_twoDW
	SetVariable setvar_twoDF value=T_twoDF
End


function Deriv(OldM,num,box,choice) //command line of 2nd derivative
	wave OldM
	variable num,box,choice
	string matname,graphname
	if(choice==1)
		matname=nameofwave(OldM)+"VD"
		duplicate/o OldM,$matname
		DM(OldM,$matname,num,box,1)
	endif
	if(choice==2)
		matname=nameofwave(OldM)+"HD"
		duplicate/o OldM,$matname
		DM(OldM,$matname,num,box,2)	
	endif
end

function curvature(mat,num,box,choice,factor) //curvature. 1 is EDC, 2 is MDC
	wave mat
	variable num,box,choice,factor
	string diff1mat,diff2mat,matcurv,graphcurv
	variable avg,avgv,avgh
	if(choice==1)
		matcurv=nameofwave(mat)+"_CurvV"
		diff1mat=nameofwave(mat)+"dy"; diff2mat=nameofwave(mat)+"dy2"
		duplicate/o mat $diff1mat,$diff2mat
		DM1(mat,$diff1mat,num,box,1)
		DM(mat,$diff2mat,num,box,1)
		avg=abs(wavemin($diff1mat))
		duplicate/o mat T_temp
		duplicate/o $diff2mat T_diff2mat; duplicate/o $diff1mat T_diff1mat
		T_temp=T_diff2mat/(avg*avg*factor+T_diff1mat*T_diff1mat)^1.5
		duplicate/o T_temp $matcurv
	endif
	if(choice==2)
		matcurv=nameofwave(mat)+"_CurvH"
		diff1mat=nameofwave(mat)+"dx"; diff2mat=nameofwave(mat)+"dx2"
		duplicate/o mat $diff1mat,$diff2mat
		DM1(mat,$diff1mat,num,box,2)
		DM(mat,$diff2mat,num,box,2)
		avg=abs(wavemin($diff1mat))
		duplicate/o mat T_temp
		duplicate/o $diff2mat T_diff2mat; duplicate/o $diff1mat T_diff1mat
		T_temp=T_diff2mat/(avg*avg*factor+T_diff1mat*T_diff1mat)^1.5
		duplicate/o T_temp $matcurv
	endif

end


function curvature2(mat,num,box,num2,box2,choice,factor) //2d curvature and 2D second derivative
	wave mat
	variable num,box,num2,box2,choice,factor
	string diff1mat,diff2mat,matcurv,graphcurv
	variable avg,avgv,avgh
	variable dx,dy,weight
	variable/g t_twoDW
	dx=dimdelta(mat,0)
	dy=dimdelta(mat,1)
	weight=(dx/dy)*(dx/dy)

	if(choice==3)			//curvature 2D
		matcurv=nameofwave(mat)+"_Curv2D"
		
		diff1mat=nameofwave(mat)+"dy"; diff2mat=nameofwave(mat)+"dy2"
		duplicate/o mat $diff1mat,$diff2mat
		DM1(mat,$diff1mat,num,box,1)
		DM(mat,$diff2mat,num,box,1)
		avgv=abs(wavemin($diff1mat))
		duplicate/o $diff2mat T_diff2matV; duplicate/o $diff1mat T_diff1matV
		
		diff1mat=nameofwave(mat)+"dx"; diff2mat=nameofwave(mat)+"dx2"
		duplicate/o mat $diff1mat,$diff2mat
		DM1(mat,$diff1mat,num2,box2,2)
		DM(mat,$diff2mat,num,box,2)
		avgh=abs(wavemin($diff1mat))
		duplicate/o $diff2mat T_diff2matH; duplicate/o $diff1mat T_diff1matH
	
		diff2mat=nameofwave(mat)+"dy"+"dx"
		duplicate/o mat $diff2mat
		DM(mat,$diff2mat,num,box,4)
		duplicate/o mat T_temp,T_maxcurv
		duplicate/o $diff2mat T_diff2matVH
		
		if(t_twoDW>0)
			weight*=t_twodW
		endif
		if(t_twoDW<0)
			weight/=abs(t_twodW)
		endif
		
		avg=max(avgv*avgv,weight*avgh*avgh)
		
		T_temp=((factor*avg+weight*t_diff1math*t_diff1math)*t_diff2matv-2*weight*t_diff1math*t_diff1matv*t_diff2matvh+weight*(factor*avg+t_diff1matv*t_diff1matv)*t_diff2math)/(factor*avg+weight*t_diff1math*t_diff1math+t_diff1matv*t_diff1matv)^1.5

		duplicate/o T_temp $matcurv
	endif
	
		if(choice==4) 			// second derivative 2D
		matcurv=nameofwave(mat)+"_Deriv2D"
		
		diff1mat=nameofwave(mat)+"dy"; diff2mat=nameofwave(mat)+"dy2"
		duplicate/o mat $diff1mat,$diff2mat
		DM1(mat,$diff1mat,num,box,1)
		DM(mat,$diff2mat,num,box,1)
		duplicate/o $diff2mat T_diff2matV; duplicate/o $diff1mat T_diff1matV
		
		diff1mat=nameofwave(mat)+"dx"; diff2mat=nameofwave(mat)+"dx2"
		duplicate/o mat $diff1mat,$diff2mat
		DM1(mat,$diff1mat,num,box,2)
		DM(mat,$diff2mat,num,box,2)
		duplicate/o $diff2mat T_diff2matH; duplicate/o $diff1mat T_diff1matH
	
		diff2mat=nameofwave(mat)+"dy"+"dx"
		duplicate/o mat $diff2mat
		DM(mat,$diff2mat,num,box,4)
		duplicate/o mat T_temp
		duplicate/o $diff2mat T_diff2matVH
		
		if(t_twoDW>0)
			weight*=t_twodW
		endif
		if(t_twoDW<0)
			weight/=abs(t_twodW)
		endif
		
		T_temp=t_diff2matV+t_diff2matH*weight
		duplicate/o T_temp $matcurv
	endif
end

function DM(OldM,NewM,num,box,choice)         //This second derivative is written by Pierre Richard.
	wave oldM,newM
	variable num,box,choice
	Variable i=0,j=0, l, m, k, x0, dx, y0, dy
	Variable j1
	Variable startofwave,endofwave
	l=dimsize(OldM,0)
	m=dimsize(OldM,1)
	x0=dimoffset(OldM,0)
	dx=dimdelta(OldM,0)
	y0=dimoffset(OldM,1)
	dy=dimdelta(OldM,1)
	make/o/n=(l) f0
	make/o/n=(m) f1
	setscale/p x x0,dx,"", f0
	setscale/p x y0,dy,"", f1
	NewM[][]=NaN
	if(choice==2) //Horizontal derivative for k-space cuts
		i=0
		do
			f0[]=OldM[p][i]
			startofwave=0
			If(mod(Round(OldM[startofwave][i]),1)!=0)
				DO
					startofwave+=1
				While((mod(Round(OldM[startofwave][i]),1)!=0)&&(startofwave<dimsize(OldM,0)+1))
			Endif
			endofwave=dimsize(OldM,0)-1
			If(mod(Round(OldM[endofwave][i]),1)!=0)
				DO
					endofwave-=1
				While((mod(Round(OldM[endofwave][i]),1)!=0)&&(endofwave>0))
			Endif
			Duplicate/O/R=[startofwave,endofwave] f0 tempwave			
			Smooth/E=3/B=(num) box,tempwave			
			differentiate tempwave
			differentiate tempwave
			NewM[startofwave,endofwave][i]=tempwave[p-startofwave]				
//			j=0
//			Do
//				NewM[startofwave+j][i]=tempwave[j]				
//				j+=1
//			While(j<dimsize(tempwave,0))
			i+=1
		while(i<dimsize(OldM,1))
		Killwaves f0,f1,tempwave
	endif
	if(choice==1)//Vertical derivative for k-space cuts
		i=0
		DO
			j=0
			If(mod(Round(OldM[i][j]),1)!=0)
				DO
					j+=1
				While((mod(Round(OldM[i][j]),1)!=0)&&(j<dimsize(OldM,1)+1))
			Endif
			If(j!=dimsize(OldM,1))
				f1[]=OldM[i][p]
				Duplicate/O/R=[j,*] f1 tempwave
				Smooth/E=3/B=(num) box,tempwave			
				differentiate tempwave
				differentiate tempwave
				f1[j,*]=tempwave[p-j]
//				j1=j
//				Do
//					f1[j1]=tempwave[j1-j]
//					j1+=1
//				While(j1<dimsize(f1,0))
				NewM[i][]=f1[q]
			Endif
			i+=1
		while(i<l)
		Killwaves f1,f0
	endif
	if(choice==4)
		Duplicate/O OldM intermediatemat
		intermediatemat[][]=NaN
		NewM[][]=NaN
		i=0				//first derivative (V)
		DO
			j=0
			If(mod(Round(OldM[i][j]),1)!=0)
				DO
					j+=1
				While((mod(Round(OldM[i][j]),1)!=0)&&(j<dimsize(OldM,1)+1))
			Endif
			If(j!=dimsize(OldM,1))
				f1[]=OldM[i][p]
				Duplicate/O/R=[j,*] f1 tempwave
				Smooth/E=3/B=(num) box,tempwave			
				differentiate tempwave
				j1=j
				Do
					f1[j1]=tempwave[j1-j]
					j1+=1
				While(j1<dimsize(f1,0))
				intermediatemat[i][]=f1[q]
			Endif
			i+=1
		while(i<l)		
		i=0                //Second derivative (H)
		do
			f0[]=intermediatemat[p][i]
			startofwave=0
			If(mod(Round(intermediatemat[startofwave][i]),1)!=0)
				DO
					startofwave+=1
				While((mod(Round(intermediatemat[startofwave][i]),1)!=0)&&(startofwave<dimsize(intermediatemat,0)+1))
			Endif
			endofwave=dimsize(intermediatemat,0)-1
			If(mod(Round(intermediatemat[endofwave][i]),1)!=0)
				DO
					endofwave-=1
				While((mod(Round(intermediatemat[endofwave][i]),1)!=0)&&(endofwave>0))
			Endif
			Duplicate/O/R=[startofwave,endofwave] f0 tempwave			
			Smooth/E=3/B=(num) box,tempwave			
			differentiate tempwave
			j=0
			Do
				NewM[startofwave+j][i]=tempwave[j]				
				j+=1
			While(j<dimsize(tempwave,0))
			i+=1
		while(i<dimsize(intermediatemat,1))
		Killwaves f0,f1,tempwave		
	endif		
	if(choice==5)
		Duplicate/O OldM intermediatemat
		intermediatemat[][]=NaN
		NewM[][]=NaN
		i=0                //first derivative (H)
		do
			f0[]=OldM[p][i]
			startofwave=0
			If(mod(Round(OldM[startofwave][i]),1)!=0)
				DO
					startofwave+=1
				While((mod(Round(OldM[startofwave][i]),1)!=0)&&(startofwave<dimsize(OldM,0)+1))
			Endif
			endofwave=dimsize(OldM,0)-1
			If(mod(Round(OldM[endofwave][i]),1)!=0)
				DO
					endofwave-=1
				While((mod(Round(OldM[endofwave][i]),1)!=0)&&(endofwave>0))
			Endif
			Duplicate/O/R=[startofwave,endofwave] f0 tempwave			
			Smooth/E=3/B=(num) box,tempwave			
			differentiate tempwave
			j=0
			Do
				intermediatemat[startofwave+j][i]=tempwave[j]				
				j+=1
			While(j<dimsize(tempwave,0))
			i+=1
		while(i<dimsize(OldM,1))
		i=0				//second derivative (V)
		DO
			j=0
			If(mod(Round(intermediatemat[i][j]),1)!=0)
				DO
					j+=1
				While((mod(Round(intermediatemat[i][j]),1)!=0)&&(j<dimsize(intermediatemat,1)+1))
			Endif
			If(j!=dimsize(intermediatemat,1))
				f1[]=intermediatemat[i][p]
				Duplicate/O/R=[j,*] f1 tempwave
				Smooth/E=3/B=(num) box,tempwave			
				differentiate tempwave
				j1=j
				Do
					f1[j1]=tempwave[j1-j]
					j1+=1
				While(j1<dimsize(f1,0))
				NewM[i][]=f1[q]
			Endif
			i+=1
		while(i<l)		
		Killwaves f0,f1,tempwave		
	endif	
End	



function DM1(OldM,NewM,num,box,choice)                            //This derivative is written by Pierre Richard.
	wave oldM,newM
	variable num,box,choice
	Variable i=0,j=0, l, m, k, x0, dx, y0, dy
	Variable j1
	Variable startofwave,endofwave
	l=dimsize(OldM,0)
	m=dimsize(OldM,1)
	x0=dimoffset(OldM,0)
	dx=dimdelta(OldM,0)
	y0=dimoffset(OldM,1)
	dy=dimdelta(OldM,1)
	make/o/n=(l) f0
	make/o/n=(m) f1
	setscale/p x x0,dx,"", f0
	setscale/p x y0,dy,"", f1
	NewM[][]=NaN
	if(choice==2) //Horizontal derivative for k-space cuts
		i=0
		do
			f0[]=OldM[p][i]
			startofwave=0
			If(mod(Round(OldM[startofwave][i]),1)!=0)
				DO
					startofwave+=1
				While((mod(Round(OldM[startofwave][i]),1)!=0)&&(startofwave<dimsize(OldM,0)+1))
			Endif
			endofwave=dimsize(OldM,0)-1
			If(mod(Round(OldM[endofwave][i]),1)!=0)
				DO
					endofwave-=1
				While((mod(Round(OldM[endofwave][i]),1)!=0)&&(endofwave>0))
			Endif
			Duplicate/O/R=[startofwave,endofwave] f0 tempwave			
			Smooth/b=(num) box,tempwave			
			differentiate tempwave
//			differentiate tempwave
			j=0
			Do
				NewM[startofwave+j][i]=tempwave[j]				
				j+=1
			While(j<dimsize(tempwave,0))
			i+=1
		while(i<dimsize(OldM,1))
		Killwaves f0,f1,tempwave
	endif
	if(choice==1)//Vertical derivative for k-space cuts
		i=0
		DO
			j=0
			If(mod(Round(OldM[i][j]),1)!=0)
				DO
					j+=1
				While((mod(Round(OldM[i][j]),1)!=0)&&(j<dimsize(OldM,1)+1))
			Endif
			If(j!=dimsize(OldM,1))
				f1[]=OldM[i][p]
				Duplicate/O/R=[j,*] f1 tempwave
				Smooth/b=(num) box,tempwave			
//				differentiate tempwave
				differentiate tempwave
				j1=j
				Do
					f1[j1]=tempwave[j1-j]
					j1+=1
				While(j1<dimsize(f1,0))
				NewM[i][]=f1[q]
			Endif
			i+=1
		while(i<l)
		Killwaves f1,f0
	endif

End	
//***********************************************************************************
function disp(mat) //disp a matrix
	wave mat
	string graphname,wavenam
	wavenam=nameofwave(mat)
	graphname=nameofwave(mat)+"_plot"
	
	if(wintype(graphname)==1)
		dowindow/f $graphname
		else
			display/n=$graphname; appendimage mat
			Showinfo	
			ModifyImage $wavenam,ctab= {*,*,Terrain}
	endif
end

function idisp(mat)
	wave mat
	string graphname,wavenam
	wavenam=nameofwave(mat)
	graphname=nameofwave(mat)+"_plot"
	
	if(wintype(graphname)==1)
		dowindow/f $graphname
		else
			display/n=$graphname; appendimage mat
			Showinfo	
			ModifyImage $wavenam,ctab= {*,0,Terrain,1}
	endif
end

//***********************************************************************************

//***********************************************************************************

macro curv_ini() :panel

variable/g T_EDCT=2
variable/g T_EDCW=5
variable/g T_EDCF=.1
variable/g t_EDCFi=.01
variable/g T_MDCT=2
variable/g T_MDCW=5
variable/g T_MDCF=.1
variable/g t_MDCFi=.01
variable/g T_twoDF=.01
variable/g T_twoDFi=.001
variable/g T_twoDW=1
variable/g T_2dUPdate=0
string/g T_curv_data_STR

If(wintype("curv_panel")==0)
	curv_data()
	execute "Curv_Panel()"
	Else
		curv_data()
		refresh_disp()
		dowindow/f curv_panel
endif

end


//***********************************************************************************
function curv_data()
string/g T_curv_data_STR
string temp

prompt temp, "Enter the wave"
doprompt "Curvature",temp
T_curv_data_STR=temp

EDCCurv()
MDCcurv()
twoDcurv()

end
//***********************************************************************************


function EDCcurv()

variable/g T_EDCT
variable/g T_EDCW
variable/g T_EDCF
string/g T_curv_data_STR

curvature($t_curv_data_str,T_edct,T_edcw,1,T_edcf)
Deriv($t_curv_data_str,T_edct,T_edcw,1)
end

//*************

function MDCcurv()

variable/g T_MDCT
variable/g T_MDCW
variable/g T_MDCF
string/g T_curv_data_STR

curvature($t_curv_data_str,T_mdct,T_mdcw,2,T_mdcf)	
Deriv($t_curv_data_str,T_mdct,T_mdcw,2)	
end

//*************

function twoDcurv()
variable/g T_EDCT
variable/g T_EDCW
variable/g T_MDCT
variable/g T_MDCW
variable/g T_twoDF
string/g T_curv_data_STR

curvature2($t_curv_data_str,T_edct,T_edcw,T_mdct,T_mdcw,3,T_twoDf)	
curvature2($t_curv_data_str,T_edct,T_edcw,T_mdct,T_mdcw,4,1)	
end








//***********************************************************************************

Window Curv_Panel() : Graph
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(139,568,680,720)
	ModifyPanel cbRGB=(32768,40777,65535)
	ShowTools/A
	SetDrawLayer UserBack
	DrawRect 122,30,430,128
	DrawText 141,72,"EDC"
	DrawText 141,97,"MDC"
	DrawText 181,48,"St. Times"
	DrawText 258,47,"St. Width"
	DrawText 339,47,"Factor"
	DrawText 141,120,"2D"
	
	Button button_EDCDisp,pos={435,55},size={30,22},proc=buttonProc_dispEDCcurv,title="C"
	Button button_MDCDisp,pos={435,80},size={30,22},proc=buttonProc_dispMDCcurv,title="C"
	Button button_2DDisp,pos={435,105},size={30,22},proc=buttonProc_disp2Dcurv,title="C"
	Button button_EDCDisp1,pos={475,55},size={30,22},proc=buttonProc_dispEDCDeriv,title="D"
	Button button_MDCDisp1,pos={475,80},size={30,22},proc=buttonProc_dispMDCDeriv,title="D"
	Button button_2DDisp1,pos={475,105},size={30,22},proc=buttonProc_disp2DDeriv,title="D"
	Button button_EDCDisp2,pos={435,28},size={66,22},proc=buttonProc_dispData,title="Disp"
	
	SetVariable setvar_EDCT,pos={189,57},size={50,15},proc=setvarEDCt,title=" "
	SetVariable setvar_EDCT,limits={1,inf,1},value= T_edct
	SetVariable setvar_EDCW,pos={264,57},size={50,15},proc=setvarEDCw,title=" "
	SetVariable setvar_EDCW,limits={1,inf,2},value= T_edcW
	SetVariable setvar_EDCF,pos={339,57},size={80,15},proc=setvarEDCF,title=" "
	SetVariable setvar_EDCF,limits={0,inf,0.01},value= T_EDCF
	SetVariable setvar_MDCT,pos={189,82},size={50,15},proc=setvarmDCt,title=" "
	SetVariable setvar_MDCT,limits={1,inf,1},value= T_MdcT
	SetVariable setvar_MDCW,pos={264,82},size={50,15},proc=setvarmDCw,title=" "
	SetVariable setvar_MDCW,limits={1,inf,2},value= T_MdcW
	SetVariable setvar_MDCF,pos={339,82},size={80,15},proc=setvarmDCF,title=" "
	SetVariable setvar_MDCF,limits={0,inf,0.01},value= T_MDCF
	SetVariable setvar_TwoDF,pos={337,105},size={80,15},proc=setvartwoDF,title=" "
	SetVariable setvar_TwoDF,limits={0,inf,1e-06},value= T_twoDF
	
	CheckBox check_2d,pos={9,107},size={96,19},title="\\Z142D UPDATE"
	CheckBox check_2d,variable= T_2dupdate
	Button button_2dCurv,pos={23,69},size={72,27},proc=buttonProc_2dCurv,title="2D Curv"
	Button button_data,pos={21,29},size={75,30},proc=buttonProc_curv_data,title="DATA"
	SetVariable setvar_twoDW,pos={190,105},size={125,15},proc=setvartwodW,title=" MDC Weight"
	SetVariable setvar_twoDw,limits={-inf,inf,1},value= T_twodW
	
EndMacro

//***********************************************************************************

Function setvarEDCt(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	edccurv()
		
	variable/g t_2dupdate
	if(t_2dupdate==1)
		twoDcurv()
	endif
	
End

//**********************

Function setvarEDCw(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	edccurv()
	variable/g t_2dupdate
	if(t_2dupdate==1)
		twoDcurv()
	endif
End

//**********************

Function setvarEDCF(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	variable/g t_edcf
	variable/g T_EDCFI

	t_edcf=ceil(t_EDCF/10^(floor(log(t_EDCF)))-1e-9)*10^(floor(log(t_EDCF)))
	t_edcfi=10^(floor(log(t_EDCF)))
	if(log(t_EDCF)==round(log(t_edcf)))
		t_EDCFI/=10
	endif
	SetVariable setvar_EDCF,limits={0,inf,t_edcfi },value= T_edcF
	
	edccurv()
	
End

//**********************

Function setvarmDCt(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	mdccurv()
	variable/g t_2dupdate
	if(t_2dupdate==1)
		twoDcurv()
	endif
	
End

//**********************

Function setvarmDCw(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	mdccurv()
	variable/g t_2dupdate
	if(t_2dupdate==1)
		twoDcurv()
	endif
	
End

//**********************

Function setvarmDCF(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	variable/g t_mdcf
	variable/g T_mDCFI
	
	t_mdcf=ceil(t_mDCF/10^(floor(log(t_mDCF)))-1e-9)*10^(floor(log(t_mDCF)))
	t_mdcfi=10^(floor(log(t_mDCF)))
	if(log(t_mDCF)==round(log(t_mdcf)))
		t_mDCFI/=10
	endif	
	SetVariable setvar_MDCF,limits={0,inf,t_mdcfi },value= T_MdcF
	
	mdccurv()
	
End

//**********************

Function setvartwoDF(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	variable/g t_twodf
	variable/g T_twodFI
	t_twodf=ceil(t_twodF/10^(floor(log(t_twodF)))-1e-10)*10^(floor(log(t_twodF)))
	t_twodfi=10^(floor(log(t_twodF)))
	if(log(t_twodF)==round(log(t_twodf)))
		t_twodFI/=10
	endif
	SetVariable setvar_TwoDF,limits={0,inf,t_twoDFi },value= T_twoDF
	
	twodcurv()
	
End

//**********************

Function setvartwoDW(ctrlName,varNum,varStr,varName): SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	
	twoDcurv()
End

//***********************************************************************************

Function ButtonProc_dispData(ctrlName) : ButtonControl
	string ctrlName
	string/g t_curv_data_str
	string data=t_curv_data_str
	disp($data)
end 

Function ButtonProc_dispEDCcurv(ctrlName) : ButtonControl
	string ctrlName
	string/g t_curv_data_str
	string data=t_curv_data_str+"_curvv"
	idisp($data)
end

Function ButtonProc_dispMDCcurv(ctrlName) : ButtonControl
	string ctrlName
	string/g t_curv_data_str
	string data=t_curv_data_str+"_curvh"
	idisp($data)
end

Function ButtonProc_disp2Dcurv(ctrlName) : ButtonControl
	string ctrlName
	string/g t_curv_data_str
	string data=t_curv_data_str+"_curv2d"
	idisp($data)
end




Function ButtonProc_dispEDCDeriv(ctrlName) : ButtonControl
	string ctrlName
	string/g t_curv_data_str
	string data=t_curv_data_str+"VD"
	idisp($data)
end

Function ButtonProc_dispMDCDeriv(ctrlName) : ButtonControl
	string ctrlName
	string/g t_curv_data_str
	string data=t_curv_data_str+"HD"
	idisp($data)
end

Function ButtonProc_disp2DDeriv(ctrlName) : ButtonControl
	string ctrlName
	string/g t_curv_data_str
	string data=t_curv_data_str+"_Deriv2D"
	idisp($data)
end


//***********************************************************************************

Function PopMenuProc_curvcolor(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

//	dowindow/f curv_panel
	SetActiveSubwindow curv_panel#G0
	ModifyImage ''#0 ctab= {*,0,$popstr,1}
	SetActiveSubwindow curv_panel#G1
	ModifyImage ''#0 ctab= {*,0,$popstr,1}
	SetActiveSubwindow curv_panel#G2
	ModifyImage ''#0 ctab= {*,0,$popstr,1}
	SetActiveSubwindow curv_panel#G3
	ModifyImage ''#0 ctab= {*,*,$popstr,0}
		
End

//***********************************************************************************

Function ButtonProc_2dCurv(ctrlName) : ButtonControl
	string ctrlName
	twoDcurv()
end

//***********************************************************************************

Function CheckProc_2dupdate(ctrlName) : CheckBoxControl //problem!!
	string ctrlName
	variable/g t_2dupdate
	if(t_2dupdate==1)
		twoDcurv()
	endif
End

//***********************************************************************************


//***********************************************************************************

Function ButtonProc_curv_data(ctrlName) : ButtonControl
	string ctrlName
	curv_data()
	refresh_disp()
end

Function refresh_disp()
	string/g t_curv_data_str
	string edcname=t_curv_data_str+"_curvv"
	string mdcname=t_curv_data_str+"_curvh"
	string twodname=t_curv_data_str+"_curv2d"	
	string graphname
	

		
End

//***********************************************************************************
//***********************************************************************************
//***********************************************************************************