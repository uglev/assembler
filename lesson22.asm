﻿ PAUS = 1
 END_MUSIC = 0
.model small
.8086
.code
int_1C_handler:
mov bx,cs:counter
shl bx,1
mov ax,word ptr cs:[bx][offset hymn]
cmp ax,END_MUSIC
jne continue
mov cs:counter,0FFFFh
iret
continue: cmp ax,PAUS
jne not_pause
in al,97
and al,0FCh
out 97,al			;Speaker off
jmp return
not_pause:
 out 66,al
 mov al,ah
 out 66,al
 in al,97
 or al,3
 out 97,al
return:
 inc cs:counter
 iret
 start:
mov ax,@data
mov ds,ax
lea dx,message
mov ah,9
int 21h
mov ah,8
int 21h
mov ax,351Ch			;Get 1C vect
int 21h
mov cs:old1c,bx
mov ax,es
mov cs:old1ch,ax		;Save 1C vector
push cs
pop ds
mov dx,offset int_1C_handler
mov ax,251ch			;Set vect
int 21h
wait_for: cmp cs:counter,0FFFFh
jne wait_for
in al,97
and al,11111100b
out 97,al			;Speaker off
lds dx,dword ptr cs:old1c
mov ax,251ch
int 21h				;Restore 1C vector
mov ax,4C00h
int 21h				;Terminate
	_C = 4559
	_CIS = 4303
	_D = 4061
	_DIS = 3833
	_E = 3619
	_F = 3416
	_FIS = 3224
	_G = 3042
	_GIS = 2872
	A = 2711
	B = 2559
	H = 2415
	Z = 2279
	CIS = 2151
	D = 2031
	DIS = 1917
	E = 1809
	F = 1708
	FIS = 1612
	G = 1521
	P = PAUS
EVEN
hymn:
	DW _G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G
	DW 12 DUP(Z,2*Z)
	DW _G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G, A,A,A,A,A,A
	DW 12 DUP(H,2*H)
	DW _E,_E,_E,_E,_E,_E,_E,_E,_E,P,P,P,_E,_E,_E,_E,_E,_E,_E,_E,_E,_E,_E,_E
	DW 12 DUP(A,2*A)
	DW _G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_G,_F,_F,_F,_F,_F,_F
	DW 12 DUP(_G,2*_G)
	DW _C,_C,_C,_C,_C,_C,_C,_C,_C,P,P,P,_C,_C,_C,_C,_C,_C,_C,_C,_C,_C,_C,_C
	DW 22 DUP(_D),2 DUP(P),6 DUP(_D,2*A),12 DUP(_E)
	DW 11 DUP(_D,_F),2 DUP(P),6 DUP(_F,_D),6 DUP(_E,_G)
	DW 12 DUP(A,_F),6 DUP(_G,H),6 DUP(A,Z),18 DUP(D,H),6 DUP(_G,2*_G)
   	DW 12 DUP(Z,E),9 DUP(_G,D), 3 DUP(Z,A),12 DUP(H,D),6 DUP(H,2*H),6 DUP(_G,2*_G)
	DW 12 DUP(A,Z),9 DUP(_E,H),3 DUP(_FIS,A),12 DUP(_G,H),10 DUP(_E),P,P,6 DUP(_E,2*_E)
	DW 12 DUP(A,2*A),6 DUP(_G,_C),6 DUP(_F,2*_F),12 DUP(_C,_G),5 DUP(_C,2*_G),P,P,6 DUP(_C,2*_E)
	DW 12 DUP(_D,Z),9 DUP(_E,H),3 DUP(A,_FIS),24 DUP(G,_G)
	DW 24 DUP(Z,E),6 DUP(D,H),6 DUP(A,Z),6 DUP(_G,H),6 DUP(A,Z)
	DW 18 DUP(H,D),6 DUP(2*H,_G),24 DUP(_G,2*_G)
	DW 24 DUP(A,Z),6 DUP(_G,H),6 DUP(A,_FIS),6 DUP(_E,_G),6 DUP(A,_FIS)
	DW 18 DUP(_G,H), 5 DUP(_E,2*_G),P,P,12 DUP(_E,2*_E)
	DW 12 DUP(A,Z),9 DUP(_F,A),3 DUP(_G,H), 12 DUP(A,Z)
	DW 9 DUP(_F,A),3 DUP(_G,H)
	DW 12 DUP(A,Z),6 DUP(_F,A),6 DUP(Z,A),18 DUP(_F,F),12 DUP(P)
	DW 16 DUP(_D,A,F)		;	!!!
	DW 4 DUP(_G,H,E)		;	!!!
	DW 6 DUP(_D,D),6 DUP(A,Z),6 DUP(H,D)
	DW 18 DUP(Z,E),5 DUP(Z,_C),P,P,6 DUP(Z,_D),6 DUP(Z,_C),6 DUP(Z,2*H),6 DUP(Z,2*A)
	DW 16 DUP(_F,A,D),4 DUP(_E,_GIS,_C),12 DUP(H),6 DUP(_FIS,A),6 DUP(_G,H)
	DW 18 DUP(A,Z),5 DUP(2*A,A),P,P,24 DUP(A,2*A)
	DW 12 DUP(Z,A),6 DUP(_G,H),6 DUP(_F,A),12 DUP(2*_G,_G)
	DW 16 DUP(_C),P,P,6 DUP(_C),12 DUP(_D,Z),9 DUP(_E,H),3 DUP(_FIS,A),24 DUP(_G,_G*2)
	DW PAUS,END_MUSIC
old1c	dw 00
old1ch	dw 00
counter dw 00
.data
message	db 10,13,'Гимн Советского Союза. Исполняет сводный оpкестp '
	db 10,13,'балалаечников Кpacнознамённого Военного Окpуга.'
	db 10,13,'Press any key when ready',10,13,'$'
.stack
end start 